import { TezosToolkit } from '@taquito/taquito';
import { InMemorySigner } from '@taquito/signer'

const Tezos = new TezosToolkit('https://ghostnet.ecadinfra.com');
const signer = new InMemorySigner('edskRtmEwZxRzwd1obV9pJzAoLoxXFWTSHbgqpDBRHx1Ktzo5yVuJ37e2R4nzjLnNbxFU4UiBU1iHzAy52pK5YBRpaFwLbByca')

Tezos.setSignerProvider(signer);

let contractAddress: any;

const originateOperation = async () => {
  const code = `parameter nat; storage nat; code { CAR ; NIL operation ; PAIR }`;
  
  console.log(`Originating a new contract...`);
  const op = await Tezos.contract.originate({
    code,
    storage: 10
  });

  console.log(`Awaiting confirmation...`);
  await op.confirmation();

  contractAddress = op.contractAddress;
  console.log(`Originated contract address: ${contractAddress}`);
}

const callContract = async () => {
  contractAddress = 'KT1DY97sFj5TZY7s3BhMeydRSV7PS19nzxAG';
  
  console.log(`Calling contract at address: ${contractAddress}`);
  const contract = await Tezos.contract.at(contractAddress);
  const op = await contract.methods.default(5).send();
  await op.confirmation();
  console.log(`Contract updated at address: ${contractAddress}`);

  // check contract call result using indexer: https://ghostnet.tzkt.io/KT1DY97sFj5TZY7s3BhMeydRSV7PS19nzxAG/operations/
}

