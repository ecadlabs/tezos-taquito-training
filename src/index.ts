import { Tezos } from "./Tezos";

const initialize = async () => {
  console.log(`Call the RPC to get the current block head`);
  
  const header = await Tezos.rpc.getBlockHeader();

  console.log(JSON.stringify(header, null, 2))
}

initialize();