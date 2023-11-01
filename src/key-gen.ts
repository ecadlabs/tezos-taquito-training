import { InMemorySigner } from '@taquito/signer';
import { b58cencode, Prefix, prefix } from '@taquito/utils';
import { writeFile } from 'node:fs/promises';
const nodeCrypto = require('crypto');

(async () => {
  let secretKey = genSecretKey();
  let signer = new InMemorySigner(secretKey);

  const key = {
    publicKeyHash: await signer.publicKeyHash(),
    publicKey: await signer.publicKey(),
    secretKey: secretKey,
  };
  await writeFile('key.json', JSON.stringify(key));
})();

// tz3 prefix publicKeyHash(address)
function genSecretKey() {
  const keyBytes = Buffer.alloc(32);
  nodeCrypto.randomFillSync(keyBytes);
  return b58cencode(new Uint8Array(keyBytes), prefix[Prefix.P2SK]);
};
