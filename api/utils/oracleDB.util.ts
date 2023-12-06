import oracledb from 'oracledb';
import { CONNECTION_STRING } from '../environment/environment';
import { User } from '../models/user.model';

let pool: oracledb.Pool;

export async function openConnection(): Promise<oracledb.Connection> {
    if (!pool) {
        pool = await oracledb.createPool({
            user: 'admin',
            password: 'MySecurePassword123',
            connectString: CONNECTION_STRING
        });
    }
    let connection;
    try {
        connection = await oracledb.getConnection(pool.poolAlias!);
    } catch (err) {
        console.error(err);
    } finally {
        return connection as oracledb.Connection;
    }
}

export async function closeConnection(connection: oracledb.Connection) {
    try {
        await connection.close();
    } catch (err) {
        console.error(err);
    }
}

export async function getUsersFromOracleDatabase(userId?: string): Promise<User[]> {
    let connection;
    let users: User[] = [];
    try {
        // Use the connection string copied from the cloud console
        // and stored in connstring.txt file from Step 2 of this tutorial
        connection = await openConnection();
        let query: string = "SELECT * FROM users"; 
        let bindParams = {};
        
        if (userId && userId.length > 0) {
            query += " WHERE id = :userId";
            bindParams = { userId : userId };
        }

        var result = await connection.execute( 
            query, 
            bindParams, 
            {
                resultSet: true, 
                outFormat: oracledb.OUT_FORMAT_OBJECT 
            }
        );

        // scan results
        const rs = result.resultSet; 
        let row: { ID: number, USERNAME: string};
        while ((row = await rs!.getRow() as { ID: number, USERNAME: string})) {
            let newUser: User = { id: row.ID,  username: row.USERNAME };
            users.push( newUser );
        }
    } catch (err) {
        console.error(err);
    } finally {
        if (connection){
            await closeConnection(connection);
        }
        return users;
    }
}