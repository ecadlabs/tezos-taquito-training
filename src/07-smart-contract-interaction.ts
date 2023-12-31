import { Tezos } from "./01-tezos";

const callContract = async () => {
  const contractAddress = 'KT1DY97sFj5TZY7s3BhMeydRSV7PS19nzxAG';
  
  console.log(`Calling contract at address: ${contractAddress}`);
  const contract = await Tezos.contract.at(contractAddress);
  const op = await contract.methods.default(5).send();
  await op.confirmation();
  console.log(`Contract updated at address: ${contractAddress}`);
  console.log(`Operation hash: ${op.hash}`);

  // check contract call result using indexer: https://ghostnet.tzkt.io/KT1DY97sFj5TZY7s3BhMeydRSV7PS19nzxAG/operations/
}

callContract();