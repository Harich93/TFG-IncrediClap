"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const audio_controllers_1 = require("../controllers/audio.controllers");
const validate_jwt_middleware_1 = __importDefault(require("../middlewares/validate-jwt.middleware"));
const validateFields_middleware_1 = __importDefault(require("../middlewares/validateFields.middleware"));
const router = (0, express_1.Router)();
router.get("/all", audio_controllers_1.getAllAudios);
router.get("/:id", audio_controllers_1.getAudio);
router.get("/", [
    validate_jwt_middleware_1.default,
    validateFields_middleware_1.default
], audio_controllers_1.getUserAudios);
router.post("/add", [
    validate_jwt_middleware_1.default,
    validateFields_middleware_1.default
], audio_controllers_1.postAudio);
router.delete("/:id", [
    validate_jwt_middleware_1.default,
    validateFields_middleware_1.default
], audio_controllers_1.deleteAudio);
exports.default = router;
//# sourceMappingURL=audio.routes.js.map