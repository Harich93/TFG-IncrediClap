import { Router } from 'express';
import { check } from 'express-validator';
import { confirmEmail, googleSingnIn, login, changePass } from '../controllers/auth.controllers';
import validateFields from '../middlewares/validateFields.middleware';

const router = Router();

router.get('/confirmEmail',confirmEmail);

router.get('/changepass/:token', changePass);

router.post('/login',
[
   check('email','Correo obligatorio').isEmail(),
   check('password','Contraseña obligatoria').not().isEmpty(),
   validateFields

],login );

router.post('/google',
[
   check('id_token', 'id_token es necesario').not().isEmpty(),
   validateFields

], googleSingnIn );


export default router;