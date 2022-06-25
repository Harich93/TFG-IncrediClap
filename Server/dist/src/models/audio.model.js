"use strict";
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
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = require("mongoose");
const AudioSchema = new mongoose_1.Schema({
    owner: {
        type: {
            type: mongoose_1.Types.ObjectId,
            ref: 'User',
        },
    },
    track: {
        type: Array,
        required: [true, 'Audio obligatorio']
    },
    title: {
        type: String,
        required: [true, 'Titulo audio obligatorio']
    },
    user_name: {
        type: String,
        required: [true, 'Nombre de usuario obligatorio']
    },
    img: {
        type: String
    },
});
AudioSchema.methods.toJSON = function () {
    const _a = this.toObject(), { __v, _id } = _a, audio = __rest(_a, ["__v", "_id"]);
    return Object.assign({ id: _id }, audio);
};
exports.default = (0, mongoose_1.model)('Audio', AudioSchema);
//# sourceMappingURL=audio.model.js.map