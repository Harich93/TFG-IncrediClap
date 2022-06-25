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
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const user_model_1 = __importDefault(require("../models/user.model"));
const validateJWT = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const token = req.header('x-token');
    if (!token)
        return res.json({
            msg: "No hay token en la petición"
        });
    try {
        const { uid } = jsonwebtoken_1.default.verify(token, process.env.SECRETKEY);
        // Datos usuario autenticado
        const userAuth = yield user_model_1.default.findById(uid);
        // Comprueba si el usuario autenticado estaba dado de baja
        if (!userAuth)
            return res.status(401).json({
                msg: "Token no válido"
            });
        else if (!userAuth.state)
            return res.status(401).json({
                msg: "Email pendiente de verificación"
            });
        req.body.userJWT = userAuth;
        next();
    }
    catch (error) {
        console.log(error);
        res.status(401).json({
            msg: "Token no válido"
        });
    }
});
exports.default = validateJWT;
//# sourceMappingURL=validate-jwt.middleware.js.map