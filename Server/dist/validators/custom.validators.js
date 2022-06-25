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
exports.existUserActiveByEmail = exports.existUserById = exports.isEmailValid = void 0;
const user_model_1 = __importDefault(require("../src/models/user.model"));
const isEmailValid = (email) => __awaiter(void 0, void 0, void 0, function* () {
    const existEmail = yield user_model_1.default.findOne({ email });
    if (existEmail)
        throw new Error(`El correo ${email} ya esta registrado`);
});
exports.isEmailValid = isEmailValid;
const existUserById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    const existUser = yield user_model_1.default.findById(id);
    if (!existUser)
        throw new Error(`El ID ${id} no existe`);
});
exports.existUserById = existUserById;
const existUserActiveByEmail = (email) => __awaiter(void 0, void 0, void 0, function* () {
    const existUser = yield user_model_1.default.findOne({ email, state: true });
    if (!existUser)
        throw new Error(`El email no es válido`);
    return existUser;
});
exports.existUserActiveByEmail = existUserActiveByEmail;
//# sourceMappingURL=custom.validators.js.map