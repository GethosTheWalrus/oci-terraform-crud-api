import oracledb from 'oracledb';
import { CONNECTION_STRING } from '../environment/environment';

export async function openConnection(): Promise<oracledb.Connection> {
    let connection;
    try {
        connection = await oracledb.getConnection(CONNECTION_STRING);
    } catch (err) {
        // console.error(err);
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