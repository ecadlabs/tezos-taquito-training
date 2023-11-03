import { Tezos } from "./Tezos";

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

const callContract = async () => {
  const contractAddress = 'KT1DY97sFj5TZY7s3BhMeydRSV7PS19nzxAG';
  
  console.log(`Calling contract at address: ${contractAddress}`);
  const contract = await Tezos.contract.at(contractAddress);
  const op = await contract.methods.default(5).send();
  await op.confirmation();
  console.log(`Contract entrypoint called at address: ${contractAddress}`);
  console.log(`Operation hash: ${op.hash}`);

  // check contract call result using indexer: https://ghostnet.tzkt.io/KT1DY97sFj5TZY7s3BhMeydRSV7PS19nzxAG/operations/
}

transactionOperation()