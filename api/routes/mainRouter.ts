import { Request, Response } from 'express';
import express from 'express';

export const mainRouter = express.Router();

mainRouter.route('/test')
    /* 
     * List all registerred users
     * output: Player[]
    */
    .get( async (req: Request, res: Response) => {
        res.send('hello world');
    })