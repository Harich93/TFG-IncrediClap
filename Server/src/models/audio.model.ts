import { Schema, model, Types } from 'mongoose';

const AudioSchema = new Schema({
    owner: {
      type: {
         type: Types.ObjectId, 
         ref: 'User',
      },
    },
    track: {
        type: Array,
        required: [ true, 'Audio obligatorio']
    },
    title: {
        type: String,
        required: [true, 'Titulo audio obligatorio']
    },
    user_name: {
        type: String,
        required: [true, 'Nombre de usuario obligatorio']
    },
    img: {
        type: String
    },
});

AudioSchema.methods.toJSON = function(){
    const { __v, _id, ...audio } = this.toObject();
    return { id: _id, ...audio };
}

export default model( 'Audio', AudioSchema );