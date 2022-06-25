import { Request, Response } from 'express';
import bcrypt from 'bcrypt'
import generateJWT from '../helpers/generate-jwt.helper';
import User from '../models/user.model';
import { existUserActiveByEmail } from '../../validators/custom.validators';
import { changePassEmail, validateEmail } from '../helpers/validate-email';

export const getUsers = async(req: Request, res: Response) => {

    let resp;

    const { from = 0, limit = 100 } = req.query;
    const query = { state: true };


    Number(limit) > 0 && Number(from) >= 0 // Validación
        
        ? resp = await Promise.all([ // Ejecución simultánea
            User.count(query),
            User.find(query)
                .skip(Number(from))
                .limit(Number(limit))
        ])
        
        : resp = ['Argumentos no válidos', 'Argumentos no válidos']


    res.json({
        "total": resp[0],
        "users": resp[1]
    });

}

export const getUser = async(req: Request, res: Response) => {

    const { id } = req.params;

    const user = await User.findById( id );

    res.send( user );
}

export const getPrivacy = async(req: Request, res: Response) => {

    const { id } = req.params;

    const user = await User.findById( id );

    res.sendFile('/html/politica.pdf', {root: __dirname});
}

export const postUser = async(req: Request, res: Response) => {

    const { google, state, ...rest } = req.body;

    let user = new User({ ...rest });

    user = await user.save();

    const token = await generateJWT( user.id ) as string;

    validateEmail(user.email, token);

    res.send( user );
}

export const putUser = async(req: Request, res: Response) => {

    let { google, state, password, ...rest } = req.body;

    const userJWT = req.body.userJWT;

    try {
        
        if(password != null) {
                
            const salt = bcrypt.genSaltSync();
            password = await bcrypt.hash(password, salt);
            
            rest = { ...rest, password}

            const user = await User.findByIdAndUpdate( userJWT.id, rest );
            
            await user.save();
        
            res.send( user );
        }  

        else {
            const user = await User.findByIdAndUpdate( userJWT.id, rest );

            res.send( user );
        }

    } catch (error) {
        res.json({msg: 'Error al intentar modificar el usuario'})
    }
    
}

export const putUserPass = async (req: Request, res: Response) => {
    
    const { email } = req.params;

    const user = await existUserActiveByEmail(email);

    if(user) {
        const token = await generateJWT(user.id);
        
        changePassEmail(email, token as string);
        res.json({msg: 'Compruebe su correo'});
    }
    
    else {
        res.json({error: 'Email no válido'});
    }


}

export const deleteUser = async(req: Request, res: Response) => {

    const { id } = req.body.userJWT;

    const user = await User.findByIdAndDelete( id );

    res.json( user );
}
