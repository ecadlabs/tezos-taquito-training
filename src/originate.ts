import { TezosToolkit } from '@taquito/taquito';
import { InMemorySigner } from '@taquito/signer';
import { env } from './config';

const Tezos = new TezosToolkit(env.rpc);
const signer = new InMemorySigner(env.secretKey);

Tezos.setSignerProvider(signer);

const originate = async () => {
  // contract that puts "Hello" in the storage
  // default entrypoint just appends what is passed as parameter to the back "Hello"
  const op = await Tezos.contract.originate({
    balance: "1",
    code: `parameter string;
  storage string;
  code {CAR;
        PUSH string "Hello ";
        CONCAT;
        NIL operation; PAIR};
  `,
    init: `"test"`
  });

  await op.confirmation();

  const address = op.contractAddress;
  // output the address of the newly originated contract
  console.log(address);
}

originate();