import { TezosToolkit } from '@taquito/taquito';
import { InMemorySigner } from '@taquito/signer'
import { env } from './config';

const Tezos = new TezosToolkit(env.rpc);
const signer = new InMemorySigner(env.secretKey)

Tezos.setSignerProvider(signer);

const initialize = async () => {
  console.log(`Call the RPC to get the current block head`);
  
  const header = await Tezos.rpc.getBlockHeader();

  console.log(JSON.stringify(header, null, 2))
}

initialize();