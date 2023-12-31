import { Tezos } from "./01-tezos";

const transactionOperation = async () => {
  console.log(`Transferring funds...`);
  const op = await Tezos.contract.transfer({
    to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L',
    amount: 0.01
  });

  console.log(`Awaiting confirmation...`);
  await op.confirmation();
  console.log(`Operation hash: ${op.hash}`);

  // check transaction result using indexer: 
}

transactionOperation()