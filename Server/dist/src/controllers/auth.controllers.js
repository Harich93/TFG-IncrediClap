"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.changePass = exports.googleSingnIn = exports.confirmEmail = exports.login = exports.getPrivacy = void 0;
const bcrypt_1 = __importDefault(require("bcrypt"));
const user_model_1 = __importDefault(require("../models/user.model"));
const generate_jwt_helper_1 = __importDefault(require("../helpers/generate-jwt.helper"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const getPrivacy = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const user = yield user_model_1.default.findById(id);
    res.sendFile('/html/politica.pdf', { root: __dirname });
});
exports.getPrivacy = getPrivacy;
const login = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { email, password } = req.body;
    try {
        const user = yield user_model_1.default.findOne({ email, state: true }); // Verifica q el usuario exista y este activo
        if (!user)
            return res.json({
                msg: "Usuario o contraseña no son correctos"
            });
        const validPass = bcrypt_1.default.compareSync(password, user.password); // Verificar password
        if (!validPass)
            return res.json({
                msg: "Usuario o contraseña no son correctos"
            });
        // Generar JWT
        const token = yield (0, generate_jwt_helper_1.default)(user.id);
        res.json({
            user,
            token
        });
    }
    catch (err) {
        console.log(err);
        res.status(500).json({
            msg: "Hable con el administrador"
        });
    }
});
exports.login = login;
const confirmEmail = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { x_token } = req.query;
        const { uid } = jsonwebtoken_1.default.verify(x_token, process.env.SECRETKEY);
        yield user_model_1.default.findByIdAndUpdate(uid, { state: true }, { new: true });
        res.redirect(`https://harich93.github.io/TFG-IncrediClap/#/verify-email`);
    }
    catch (error) {
        res.status(500).json({
            msg: "Hable con el administrador"
        });
    }
});
exports.confirmEmail = confirmEmail;
const googleSingnIn = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id_token } = req.body;
    try {
        const { name, img, email } = yield googleVerify(id_token); // Verificacion token goole
        let user = yield user_model_1.default.findOne({ email }); // Busca si el usuario esta en la db
        console.log(user);
        if (!user) { // Crea el usuario en db si no está
            const data = {
                name,
                img,
                email,
                password: '1234567',
                google: true
            };
            user = new user_model_1.default(data);
            console.log(user);
            yield user.save();
        }
        // Valida que el usuario no esté bloqueado/eliminado        
        if (!user.state)
            return res.status(401).json({
                msg: 'Usuario bloqueado, hable con el administrador'
            });
        // Generar JWT
        const token = yield (0, generate_jwt_helper_1.default)(user.id);
        res.json({
            user,
            token
        });
    }
    catch (error) {
        res.status(400).json({
            ok: false,
            msg: 'El token no se pudo verificar'
        });
    }
});
exports.googleSingnIn = googleSingnIn;
const changePass = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { token } = req.params;
        res.redirect(`https://harich93.github.io/TFG-IncrediClap/#/change-pass?token=${token}`);
    }
    catch (error) {
        res.status(500).json({
            msg: "Hable con el administrador"
        });
    }
});
exports.changePass = changePass;
//# sourceMappingURL=auth.controllers.js.map