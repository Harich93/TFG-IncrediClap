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
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteUser = exports.putUserPass = exports.putUser = exports.postUser = exports.getPrivacy = exports.getUser = exports.getUsers = void 0;
const bcrypt_1 = __importDefault(require("bcrypt"));
const generate_jwt_helper_1 = __importDefault(require("../helpers/generate-jwt.helper"));
const user_model_1 = __importDefault(require("../models/user.model"));
const custom_validators_1 = require("../../validators/custom.validators");
const validate_email_1 = require("../helpers/validate-email");
const getUsers = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    let resp;
    const { from = 0, limit = 100 } = req.query;
    const query = { state: true };
    Number(limit) > 0 && Number(from) >= 0 // Validación
        ? resp = yield Promise.all([
            user_model_1.default.count(query),
            user_model_1.default.find(query)
                .skip(Number(from))
                .limit(Number(limit))
        ])
        : resp = ['Argumentos no válidos', 'Argumentos no válidos'];
    res.json({
        "total": resp[0],
        "users": resp[1]
    });
});
exports.getUsers = getUsers;
const getUser = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const user = yield user_model_1.default.findById(id);
    res.send(user);
});
exports.getUser = getUser;
const getPrivacy = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const user = yield user_model_1.default.findById(id);
    res.sendFile('/html/politica.pdf', { root: __dirname });
});
exports.getPrivacy = getPrivacy;
const postUser = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const _a = req.body, { google, state } = _a, rest = __rest(_a, ["google", "state"]);
    let user = new user_model_1.default(Object.assign({}, rest));
    user = yield user.save();
    const token = yield (0, generate_jwt_helper_1.default)(user.id);
    (0, validate_email_1.validateEmail)(user.email, token);
    res.send(user);
});
exports.postUser = postUser;
const putUser = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    let _b = req.body, { google, state, password } = _b, rest = __rest(_b, ["google", "state", "password"]);
    const userJWT = req.body.userJWT;
    try {
        if (password != null) {
            const salt = bcrypt_1.default.genSaltSync();
            password = yield bcrypt_1.default.hash(password, salt);
            rest = Object.assign(Object.assign({}, rest), { password });
            const user = yield user_model_1.default.findByIdAndUpdate(userJWT.id, rest);
            yield user.save();
            res.send(user);
        }
        else {
            const user = yield user_model_1.default.findByIdAndUpdate(userJWT.id, rest);
            res.send(user);
        }
    }
    catch (error) {
        res.json({ msg: 'Error al intentar modificar el usuario' });
    }
});
exports.putUser = putUser;
const putUserPass = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { email } = req.params;
    const user = yield (0, custom_validators_1.existUserActiveByEmail)(email);
    if (user) {
        const token = yield (0, generate_jwt_helper_1.default)(user.id);
        (0, validate_email_1.changePassEmail)(email, token);
        res.json({ msg: 'Compruebe su correo' });
    }
    else {
        res.json({ error: 'Email no válido' });
    }
});
exports.putUserPass = putUserPass;
const deleteUser = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.body.userJWT;
    const user = yield user_model_1.default.findByIdAndDelete(id);
    res.json(user);
});
exports.deleteUser = deleteUser;
//# sourceMappingURL=users.controllers.js.map