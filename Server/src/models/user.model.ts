import { Schema, model, Types } from 'mongoose';
import bcrypt from 'bcrypt'


const UserSchema = new Schema({
    name: {
        type: String,
        required: [ true, 'Nombre obligatorio']
    },
    email: {
        type: String,
        required: [ true, 'Email obligatorio']
    },
    password: {
        type: String,
        required: [ true, 'Contraseña obligatoria']
    },
    img: {
        type: String
    },
    state: {
        type: Boolean,
        default: false
    },
    google: {
        type: Boolean,
        default: false
    },
    audios: {
        type: [{type:Types.ObjectId, ref: 'Audio'}]
    }, 
});

UserSchema.pre('save', async function (next) {
    const user = this;

    if (user.isModified('password')) {
        const salt = bcrypt.genSaltSync();
        user.password = await bcrypt.hash(user.password, salt);
    }

    next();
})

UserSchema.methods.toJSON = function(){
    const { __v, _id, password, ...user } = this.toObject();
    return { uid: _id, ...user };
}

export default model( 'User', UserSchema );