import { TezosToolkit, OpKind } from '@taquito/taquito';
import { InMemorySigner } from '@taquito/signer';
import { env } from './config';


const Tezos = new TezosToolkit(env.rpc);
const signer = new InMemorySigner(env.secretKey)

Tezos.setSignerProvider(signer);

const batchOperation = async () => {

  // 1st syntax
  const batchOp = await Tezos.contract
    .batch()
    .withTransfer({ to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L', amount: 0.02 })
    .withTransfer({ to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L', amount: 0.02 })

  const op = await batchOp.send();

  console.log(op);

  await op.confirmation();
}

const batchOperation2 = async () => {
  
  // 2nd syntax
  const batchOp = await Tezos.contract
    .batch([
      { kind: OpKind.TRANSACTION, to: 'tz1ZfrERcALBwmAqwonRXYVQBDT9BjNjBHJu', amount: 0.02 },
      { kind: OpKind.TRANSACTION, to: 'tz1ZfrERcALBwmAqwonRXYVQBDT9BjNjBHJu', amount: 0.02 },
    ])
    .send();

  await batchOp.confirmation();

  console.log(batchOp);
}

// batchOperation();