"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const express_validator_1 = require("express-validator");
const auth_controllers_1 = require("../controllers/auth.controllers");
const validateFields_middleware_1 = __importDefault(require("../middlewares/validateFields.middleware"));
const router = (0, express_1.Router)();
router.get('/confirmEmail', auth_controllers_1.confirmEmail);
router.get('/changepass/:token', auth_controllers_1.changePass);
router.post('/login', [
    (0, express_validator_1.check)('email', 'Correo obligatorio').isEmail(),
    (0, express_validator_1.check)('password', 'Contraseña obligatoria').not().isEmpty(),
    validateFields_middleware_1.default
], auth_controllers_1.login);
router.post('/google', [
    (0, express_validator_1.check)('id_token', 'id_token es necesario').not().isEmpty(),
    validateFields_middleware_1.default
], auth_controllers_1.googleSingnIn);
exports.default = router;
//# sourceMappingURL=auth.routes.js.map