// process.env
export const CONNECTION_STRING: string = process.env.ORACLEDB_CONNECTION_STRING || '';
export const ROOT_URL: string = process.env.SITEURL || 'localhost:3000';
export const INFRA: string = process.env.INFRA || 'oci';
export const DEPLOYMENT: string = process.env.DEPLOYMENT || 'normal'