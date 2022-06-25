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
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const db_config_1 = __importDefault(require("../db/db.config"));
const users_routes_1 = __importDefault(require("../routes/users.routes"));
const auth_routes_1 = __importDefault(require("../routes/auth.routes"));
const audio_routes_1 = __importDefault(require("../routes/audio.routes"));
class Server {
    constructor() {
        this._app = (0, express_1.default)();
        this._port = process.env.PORT || '8082';
        this.connectionDB();
        this.middlewares();
        this.routes();
    }
    connectionDB() {
        return __awaiter(this, void 0, void 0, function* () {
            yield (0, db_config_1.default)();
        });
    }
    middlewares() {
        this._app.use((0, cors_1.default)());
        this._app.use(express_1.default.json());
    }
    routes() {
        this._app.use('/users', users_routes_1.default);
        this._app.use('/audios', audio_routes_1.default);
        this._app.use('/auth', auth_routes_1.default);
        this._app.use(express_1.default.static(__dirname + '/public'));
    }
    listen() {
        this._app.listen(this._port, () => {
            console.log('Corriendo en el puerto: ' + this._port);
        });
    }
}
exports.default = Server;
//# sourceMappingURL=server.model.js.map