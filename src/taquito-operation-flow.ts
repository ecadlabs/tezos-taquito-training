import { TezosToolkit } from '@taquito/taquito';
import { InMemorySigner } from '@taquito/signer';
import { LocalForger } from '@taquito/local-forging';


const operationFlow = async () => {
  const Tezos = new TezosToolkit('https://ghostnet.ecadinfra.com');
  const signer = new InMemorySigner('edskRtmEwZxRzwd1obV9pJzAoLoxXFWTSHbgqpDBRHx1Ktzo5yVuJ37e2R4nzjLnNbxFU4UiBU1iHzAy52pK5YBRpaFwLbByca')

  Tezos.setSignerProvider(signer);

  const estimate = await Tezos.estimate.transfer({ to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L', amount: 1 });

  console.log(`Estimates for the transfer operation: `);
  console.log(`Fee: ${estimate.suggestedFeeMutez}`);
  console.log(`Gas limit: ${estimate.gasLimit}`);
  console.log(`Storage limit: ${estimate.storageLimit}`);


  const prepare = await Tezos.prepare.transaction({ 
    to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L', 
    amount: 1,
    fee: estimate.suggestedFeeMutez,
    gasLimit: estimate.gasLimit,
    storageLimit: estimate.storageLimit 
  });

  console.log(`Prepared operation: `);
  console.log(JSON.stringify(prepare, null, 2));

  const forgeableOperation = await Tezos.prepare.toForge(prepare);
  const forger = new LocalForger();

  console.log(`Forging operation...`)
  const forgedOp = await forger.forge(forgeableOperation);
  
  console.log(`Forged operation: ${forgedOp}`);

  console.log(`Signing operation...`);

  const signedOp = await Tezos.signer.sign(forgedOp, new Uint8Array([3]));

  console.log(`Signed operation: ${signedOp}`);

  console.log(`Injecting operation...`);

  const op = await Tezos.rpc.injectOperation(signedOp.sbytes);


  console.log(`opHash: ${op}`)
}

operationFlow();