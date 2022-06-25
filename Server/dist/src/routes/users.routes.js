"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const express_validator_1 = require("express-validator");
const custom_validators_1 = require("../../validators/custom.validators");
const users_controllers_1 = require("../controllers/users.controllers");
const validateFields_middleware_1 = __importDefault(require("../middlewares/validateFields.middleware"));
const validate_jwt_middleware_1 = __importDefault(require("../middlewares/validate-jwt.middleware"));
const router = (0, express_1.Router)();
router.get('/', users_controllers_1.getUsers);
router.get('/privacy', users_controllers_1.getPrivacy);
router.get('/:id', [
    (0, express_validator_1.check)('id', 'ID no válido').isMongoId(),
    validateFields_middleware_1.default
], users_controllers_1.getUser);
router.post('/', [
    (0, express_validator_1.check)('name', 'El nombre es obligatorio').not().isEmpty(),
    (0, express_validator_1.check)('email').custom(custom_validators_1.isEmailValid),
    (0, express_validator_1.check)('password', 'La contraseña de ser de minimo 6 carácteres').isLength({ min: 6 }),
    validateFields_middleware_1.default
], users_controllers_1.postUser);
router.put('/', [
    validate_jwt_middleware_1.default,
    validateFields_middleware_1.default
], users_controllers_1.putUser);
router.put('/pass/:email', [
    (0, express_validator_1.check)('email', 'No es un email válido').isEmail(),
    validateFields_middleware_1.default
], users_controllers_1.putUserPass);
router.delete('/:id', [
    validate_jwt_middleware_1.default,
    (0, express_validator_1.check)('id', 'No es un ID válido').isMongoId(),
    (0, express_validator_1.check)('id').custom(custom_validators_1.existUserById),
    validateFields_middleware_1.default
], users_controllers_1.deleteUser);
exports.default = router;
//# sourceMappingURL=users.routes.js.map