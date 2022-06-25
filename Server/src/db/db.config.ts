import mongoose from 'mongoose';


const dbConnection = async() => {

    try {
        
        await mongoose.connect( process.env.MONGODB_CNN!, { autoIndex: true } );

    } catch (err) {
        console.log( err );
        throw new Error('Error en la conexión de con mongoDB');
    }
}

export default dbConnection;