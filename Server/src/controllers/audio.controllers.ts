import { Response, Request } from 'express';
import Audio from '../models/audio.model';
import User from '../models/user.model';

interface itrack {
    idAudio: number,
    volume: number,
    duration: string,
}

export const getAllAudios = async(req: Request, res: Response ) => {

   let resp;

   const { from = 0, limit = 100 } = req.query;
   const query = { state: true };


   Number(limit) > 0 && Number(from) >= 0 // Validación
       
       ? resp = await Promise.all([ // Ejecución simultánea
           Audio.count(query),
           Audio.find(query)
               .skip(Number(from))
               .limit(Number(limit))
       ])
       
       : resp = ['Argumentos no válidos', 'Argumentos no válidos']


   res.json({
       "total": resp[0],
       "audios": resp[1]
   });

} 

export const getAudio = async(req: Request, res: Response ) => {
   
    try {

       const { id } = req.params;
       const audio = await Audio.findById( id );
       
       audio
        ? res.send( audio )
        : res.status(404).json({ msg: "Audio no encontrado" })

        
    } catch (error) {
          console.log(error)
    }
 } 

export const getUserAudios = async(req: Request, res: Response ) => {
   
   try {
      const us = req.body.userJWT;

      const { audios } = await us.populate({ path: 'audios' });

      res.send( audios );
      
   } catch (error) {
       res.status(400).send(error)
   }
} 

export const postAudio = async( req: Request, res: Response ) => {

    const { userJWT: user, track, title } = req.body;
    let tr: itrack;
    
    try {

        tr = track
        const audio = new Audio({ 
            owner: user.id, 
            user_name: user.name,
            track: tr,
            title
        });
        await audio.save();
    
        await User.findByIdAndUpdate( user.id, {$push:{ audios: audio._id }})
    
        res.send(audio);

    } catch (error) {
        res.status(404).json({msg: 'Trak no válido'})
    }


    // ^ Subir imagen
    // if( req.files?.img ) {
    //     const { tempFilePath } = req.files?.img as UploadedFile;
    //     const { secure_url } = await cloudinary.uploader.upload( tempFilePath )

    //     audio.img = secure_url;
    //^ } 



} 

export const deleteAudio = async(req: Request, res: Response ) => {

    const { id } = req.params;

    const audio = await Audio.findByIdAndDelete( id );

    res.json( audio );
   
} 
