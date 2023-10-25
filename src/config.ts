import path from 'path';
import * as dotenv from "dotenv";
dotenv.config({ path: path.resolve(__dirname, '../.env.dev')});

export const env = {
  rpc: process.env.RPC || 'https://ghostnet.ecadinfra.com',
  secretKey: process.env.SECRET_KEY || '',
  contractAddress: process.env.CONTRACT_ADDRESS || '',
}