import { DynamoDBClient, QueryCommand, ScanCommand, ScanCommandOutput } from "@aws-sdk/client-dynamodb";
import { User } from "../models/user.model";

const client = new DynamoDBClient();

export const getUsersFromDynamoDB = async (userId?: string) => {
    let users: User[] = [];
    let command;
    
    if (userId) {
        command = new QueryCommand({
            KeyConditionExpression: "#id = :id",
            ExpressionAttributeNames: {
                "#id": "id"
            },
            ExpressionAttributeValues: {
                ":id": {"N": userId || "0"},
            },
            TableName: "demo_table",
        });
    } else {
        command = new ScanCommand({
            TableName: "demo_table", 
        });
    }

    const response: ScanCommandOutput = await client.send(command);

    response.Items!.forEach(function (user) {
        let newUser: User = { id: parseInt(user.id.N!), username: user.username.S! }
        users.push(newUser);
    });
    
    return users; 
};