import { TezosToolkit } from '@taquito/taquito';
import { InMemorySigner } from '@taquito/signer';
import { env } from './config';

export const Tezos = new TezosToolkit(env.rpc);
const signer = new InMemorySigner(env.secretKey);
Tezos.setSignerProvider(signer);
