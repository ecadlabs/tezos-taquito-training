import { LocalForger } from '@taquito/local-forging';
import { Tezos } from './Tezos';


const operationFlow = async () => {
  const estimate = await Tezos.estimate.transfer({ to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L', amount: 1 });

  console.log(`Estimates for the transfer operation: `);
  console.log(`Fee: ${estimate.suggestedFeeMutez}`);
  console.log(`Gas limit: ${estimate.gasLimit}`);
  console.log(`Storage limit: ${estimate.storageLimit} \n`);


  const prepared = await Tezos.prepare.transaction({ 
    to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L', 
    amount: 1,
    fee: estimate.suggestedFeeMutez,
    gasLimit: estimate.gasLimit,
    storageLimit: estimate.storageLimit 
  });

  console.log(`Prepared operation: `);
  console.log(`${JSON.stringify(prepared, null, 2)} \n`);

  const forgeableOperation = Tezos.prepare.toForge(prepared);
  const forger = new LocalForger();

  console.log(`Forging operation...`)
  const forgedOp = await forger.forge(forgeableOperation);
  
  console.log(`Forged operation: ${forgedOp} \n`);

  console.log(`Signing operation...`);

  const signedOp = await Tezos.signer.sign(forgedOp, new Uint8Array([3]));

  console.log(`Signed operation: ${JSON.stringify(signedOp)} \n`);

  console.log(`Injecting operation...`);

  const op = await Tezos.rpc.injectOperation(signedOp.sbytes);


  console.log(`opHash: ${op}`)
}

operationFlow();