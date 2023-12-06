import cors from 'cors';
import express from 'express';
import bodyparser from 'body-parser';
import { mainRouter } from '../routes/mainRouter';
import { INFRA } from '../environment/environment';
import { openConnection, closeConnection } from '../utils/oracleDB.util';

export class ServerService {  
    static app = express();
    static server = require('http').createServer(this.app);
    static healthy: boolean = false; 

    /*
     * Initialize the express http server
    */
    static initServer() {
        switch (INFRA) {
            case 'oci': {
                console.log('running on OCI');
                ServerService.seedOracleDatabase();
                break;
            } case 'aws': {
                console.log('running on AWS')
                break;
            }
        }

        // connect the additional modules and the routers to the http server
        ServerService.app.use(bodyparser.json());
        ServerService.app.use(cors());
        ServerService.app.use(mainRouter);
    }

    static startServer() {
        ServerService.server.listen(3000);
    }

    static async seedOracleDatabase() {
        let connection;
        try {
            // Use the connection string copied from the cloud console
            // and stored in connstring.txt file from Step 2 of this tutorial
            connection = await openConnection();

            // Create a table
            await connection.execute(`begin execute immediate 'drop table users'; exception when others then if sqlcode <> -942 then raise; end if; end;`); 
            await connection.execute(`create table users (id number, username varchar2(100))`); 

            // Insert some rows
            const sql = `INSERT INTO users VALUES (:1, :2)`; const binds = [ [1, "user1" ], [2, "user2" ], [3, "user3" ], [4, "user4" ], [5, "user5" ], [6, "user6" ], [7, "user7" ] ];
            await connection.executeMany(sql, binds);
            connection.commit(); 
        } catch (err) {
            console.error(err);
        } finally {
            if (connection){
                await closeConnection(connection);
            }
        }
    }
}