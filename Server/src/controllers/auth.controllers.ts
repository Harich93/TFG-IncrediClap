import { Request, Response } from "express";
import bcryptjs from 'bcrypt';
import User from "../models/user.model";
import generateJWT from "../helpers/generate-jwt.helper";
import jwt, { JwtPayload } from 'jsonwebtoken';


export const getPrivacy = async(req: Request, res: Response) => {

    const { id } = req.params;

    const user = await User.findById( id );

    res.sendFile('/html/politica.pdf', {root: __dirname});
}

export const login = async( req: Request, res: Response ) => {

    
    const { email, password } = req.body;
    
    try {
        
      const user = await User.findOne( {email, state: true} ); // Verifica q el usuario exista y este activo

        if(!user) return res.json({
            msg: "Usuario o contraseña no son correctos"
        });
        
      const validPass = bcryptjs.compareSync( password, user.password ); // Verificar password

        if(!validPass) return res.json({
            msg: "Usuario o contraseña no son correctos"
        });

      // Generar JWT
      const token = await generateJWT( user.id );

      res.json({
        user,
        token
      });

   } catch (err) {
      
      console.log(err);
        res.status(500).json({
            msg: "Hable con el administrador"
        });
   }

}

export const confirmEmail = async( req: Request, res: Response ) => {
    
    try {
        const { x_token } = req.query;
        const { uid } = jwt.verify( x_token as string, process.env.SECRETKEY! ) as JwtPayload;
        await User.findByIdAndUpdate( uid, { state: true},{ new: true});
        res.redirect(`https://harich93.github.io/TFG-IncrediClap/#/verify-email`);

    } catch (error) {
        res.status(500).json({
            msg: "Hable con el administrador"
        });
    }

}

export const googleSingnIn = async( req: Request, res: Response ) => {
    
   const { id_token } = req.body;
   
   try {
       const { name, img, email } = await googleVerify( id_token ); // Verificacion token goole
       
       let user = await User.findOne({ email }); // Busca si el usuario esta en la db
       
       console.log(user);
       if(!user) { // Crea el usuario en db si no está
           
           const data = { 
               name,
               img,
               email,
               password: '1234567',
               google: true 
           };
           
           user = new User( data ); 
           console.log( user )
           await user.save();
       }
       
       
       // Valida que el usuario no esté bloqueado/eliminado        
       if(!user.state) return res.status(401).json({ 
           msg: 'Usuario bloqueado, hable con el administrador'
       });
       
       // Generar JWT
       const token = await generateJWT( user.id );
       
       res.json({
           user,
           token
        });
        
    } catch (error) {
       
       res.status(400).json({
           ok: false,
           msg: 'El token no se pudo verificar'
        });
    }
    
}

export const changePass = async ( req: Request, res: Response ) => {
    
    try {
        const { token } = req.params;
        
        res.redirect(`https://harich93.github.io/TFG-IncrediClap/#/change-pass?token=${token}`);
        
    } catch (error) {
        res.status(500).json({
            msg: "Hable con el administrador" 
        });
    }
}           