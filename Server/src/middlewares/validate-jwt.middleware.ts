import { NextFunction, Request, Response } from "express";
import jwt, { JwtPayload } from 'jsonwebtoken';
import User from "../models/user.model";

const validateJWT = async ( req: Request, res: Response, next: NextFunction ) => {
    
   const token = req.header('x-token');

   if(!token) return res.json({
       msg: "No hay token en la petición"
   }); 
   
   try {

       const { uid } = jwt.verify( token, process.env.SECRETKEY! ) as JwtPayload;
       // Datos usuario autenticado
       const userAuth = await User.findById( uid );
       
       // Comprueba si el usuario autenticado estaba dado de baja
       if( !userAuth ) return res.status(401).json({
            msg: "Token no válido"
       });
        
        else if(!userAuth.state ) return res.status(401).json({
           msg: "Email pendiente de verificación"
        });
      
       req.body.userJWT = userAuth;

       next();

   } catch (error) {
       
       console.log(error);
       
       res.status(401).json({
           msg: "Token no válido"
       });
   }
}

export default validateJWT;