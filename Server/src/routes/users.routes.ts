import { Router } from 'express';
import { check } from 'express-validator';

import { existUserById, isEmailValid } from '../../validators/custom.validators';
import { getUsers, getUser, postUser, deleteUser, putUserPass, putUser, getPrivacy } from '../controllers/users.controllers';
import validateFields from '../middlewares/validateFields.middleware';
import validateJWT from '../middlewares/validate-jwt.middleware';


const router = Router();

router.get('/', getUsers);
router.get('/privacy', getPrivacy);

router.get('/:id',[
    check('id', 'ID no válido').isMongoId(),
    validateFields
], getUser);

router.post('/',[
    check('name','El nombre es obligatorio').not().isEmpty(),
    check('email').custom( isEmailValid ),
    check('password','La contraseña de ser de minimo 6 carácteres').isLength({min:6}),
    validateFields
], postUser);

router.put('/', 
[
    validateJWT,
    validateFields

],putUser );

router.put('/pass/:email', 
[
    check('email', 'No es un email válido').isEmail(),
    validateFields

],putUserPass );

router.delete('/:id', 
[
    validateJWT,
    check('id', 'No es un ID válido').isMongoId(),
    check('id').custom( existUserById ),
    validateFields
    
], deleteUser );

export default router;