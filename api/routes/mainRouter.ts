import { Request, Response } from 'express';
import express from 'express';
import { getUsersFromDatabase } from '../services/database.service'
import { User } from '../models/user.model';

export const mainRouter = express.Router();

mainRouter.route('/users')
    /* 
     * List all registerred users
     * output: User[]
    */
    .get( async (req: Request, res: Response) => {
        let users: User[] = await getUsersFromDatabase();
        res.send(users);
    });

mainRouter.route('/users/:userid')
    /* 
     * Retrieve a registerred user
     * output: User[]
    */
    .get( async (req: Request, res: Response) => { 
        let users: User[] = await getUsersFromDatabase(req.params.userid);
        res.send(users); 
    })