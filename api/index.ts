import 'dotenv/config';
// import serverless from 'serverless-http';
import { ServerService } from './services/server.service';
import { DEPLOYMENT } from './environment/environment';

 const serverless = require('serverless-http');

ServerService.initServer();

console.log('DEPLOYMENT STARATEGY:', DEPLOYMENT);
if (DEPLOYMENT == 'serverless') {
    console.log('USERING SERVERLESS-HTTP');
    module.exports.handler = serverless(ServerService.app, {});
} else {
    ServerService.startServer(); 
}