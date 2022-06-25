import jwt, { Secret } from "jsonwebtoken";

const generateJWT = ( uid: string ):Promise<string | undefined> => {

   return new Promise( (resolve, reject) => {
      
      const secretKey = process.env.SECRETKEY as Secret;
      const payload = { uid };

      jwt.sign( payload, secretKey, { expiresIn: '4h' }, ( err, token ) => {
         err
            ? reject('No se generó el token')
            : resolve(token);
      });
   });

}

export default generateJWT;