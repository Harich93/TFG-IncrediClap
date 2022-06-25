import User from "../src/models/user.model";


export const isEmailValid = async( email: string ) => {
    const existEmail = await User.findOne( {email} );
     
    if( existEmail ) 
        throw new Error(`El correo ${ email } ya esta registrado`);
}

export const existUserById = async( id: string ) => {
    const existUser = await User.findById( id );
     
    if( !existUser ) 
        throw new Error(`El ID ${ id } no existe`);
    
    
}

export const existUserActiveByEmail = async( email: string ) => {
    const existUser = await User.findOne( { email, state: true } );
     
    if( !existUser ) 
        throw new Error(`El email no es válido`);

    return existUser;
}
