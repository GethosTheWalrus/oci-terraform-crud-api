import cors from 'cors';
import express from 'express';
import bodyparser from 'body-parser';
import { mainRouter } from '../routes/mainRouter';

export class ServerService {  
    static app = express();
    static server = require('http').createServer(this.app);
    static healthy: boolean = false;

    /*
     * Initialize the express http server
    */
    static initServer() {
        // connect the additional modules and the routers to the http server
        ServerService.app.use(bodyparser.json());
        ServerService.app.use(cors());
        ServerService.app.use(mainRouter);
    }

    static startServer() {
        ServerService.server.listen(3000);
    }
}