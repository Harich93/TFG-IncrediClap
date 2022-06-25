"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const generateJWT = (uid) => {
    return new Promise((resolve, reject) => {
        const secretKey = process.env.SECRETKEY;
        const payload = { uid };
        jsonwebtoken_1.default.sign(payload, secretKey, { expiresIn: '4h' }, (err, token) => {
            err
                ? reject('No se generó el token')
                : resolve(token);
        });
    });
};
exports.default = generateJWT;
//# sourceMappingURL=generate-jwt.helper.js.map