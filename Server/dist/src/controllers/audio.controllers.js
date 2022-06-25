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
exports.deleteAudio = exports.postAudio = exports.getUserAudios = exports.getAudio = exports.getAllAudios = void 0;
const audio_model_1 = __importDefault(require("../models/audio.model"));
const user_model_1 = __importDefault(require("../models/user.model"));
const getAllAudios = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    let resp;
    const { from = 0, limit = 100 } = req.query;
    const query = { state: true };
    Number(limit) > 0 && Number(from) >= 0 // Validación
        ? resp = yield Promise.all([
            audio_model_1.default.count(query),
            audio_model_1.default.find(query)
                .skip(Number(from))
                .limit(Number(limit))
        ])
        : resp = ['Argumentos no válidos', 'Argumentos no válidos'];
    res.json({
        "total": resp[0],
        "audios": resp[1]
    });
});
exports.getAllAudios = getAllAudios;
const getAudio = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const audio = yield audio_model_1.default.findById(id);
        audio
            ? res.send(audio)
            : res.status(404).json({ msg: "Audio no encontrado" });
    }
    catch (error) {
        console.log(error);
    }
});
exports.getAudio = getAudio;
const getUserAudios = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const us = req.body.userJWT;
        const { audios } = yield us.populate({ path: 'audios' });
        res.send(audios);
    }
    catch (error) {
        res.status(400).send(error);
    }
});
exports.getUserAudios = getUserAudios;
const postAudio = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { userJWT: user, track, title } = req.body;
    let tr;
    try {
        tr = track;
        const audio = new audio_model_1.default({
            owner: user.id,
            user_name: user.name,
            track: tr,
            title
        });
        yield audio.save();
        yield user_model_1.default.findByIdAndUpdate(user.id, { $push: { audios: audio._id } });
        res.send(audio);
    }
    catch (error) {
        res.status(404).json({ msg: 'Trak no válido' });
    }
    // ^ Subir imagen
    // if( req.files?.img ) {
    //     const { tempFilePath } = req.files?.img as UploadedFile;
    //     const { secure_url } = await cloudinary.uploader.upload( tempFilePath )
    //     audio.img = secure_url;
    //^ } 
});
exports.postAudio = postAudio;
const deleteAudio = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const audio = yield audio_model_1.default.findByIdAndDelete(id);
    res.json(audio);
});
exports.deleteAudio = deleteAudio;
//# sourceMappingURL=audio.controllers.js.map