import express, { Application } from "express";
import cors from 'cors';

import dbConnection from "../db/db.config";

import usersRouter from "../routes/users.routes";
import authRouter from "../routes/auth.routes";
import audioRouter from "../routes/audio.routes";


class Server {

    private _app: Application;
    private _port: string;

    constructor() {
        this._app = express();
        this._port = process.env.PORT || '8082';

        this.connectionDB();
        
        this.middlewares();
        this.routes();
    }

    async connectionDB() {
        await dbConnection();
    }

    middlewares() {
        this._app.use( cors() );
        this._app.use( express.json() );
    }

    routes() {
        this._app.use('/users', usersRouter);
        this._app.use('/audios', audioRouter)
        this._app.use('/auth', authRouter);
        this._app.use( express.static(__dirname + '/public') );
    }


    listen() {
        this._app.listen( this._port, () => {
            console.log('Corriendo en el puerto: ' + this._port);
        });
    }

}

export default Server;