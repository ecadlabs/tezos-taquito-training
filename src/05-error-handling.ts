import { Tezos } from "./01-tezos";

const errorHandling = async () => {
  console.log(`Transferring funds...`);
  
  // This will result in an 'InvalidAddressError'
  try {
    const op = await Tezos.contract.transfer({
      to: 'a',
      amount: 0.01
    });
  
    console.log(`Awaiting confirmation...`);
    await op.confirmation();
    console.log(`Operation hash: ${op.hash}`);
  } catch(e) {
    console.log(e);
  }
}

errorHandling();
