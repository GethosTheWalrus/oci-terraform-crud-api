import { INFRA } from "../environment/environment";
import { User } from "../models/user.model";
import { getUsersFromDynamoDB } from "../utils/dynamoDB.util";
import { getUsersFromOracleDatabase } from "../utils/oracleDB.util"

export async function getUsersFromDatabase(userId?: string): Promise<User[]> {
    let users: User[];
    switch (INFRA) {
        case 'oci': {
            users = await getUsersFromOracleDatabase(userId);
            break;
        } case 'aws': {
            users = await getUsersFromDynamoDB(userId); 
            break; 
        } default: {
            users = []; 
        }
    }
    
    return users;
}