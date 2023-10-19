"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const taquito_1 = require("@taquito/taquito");
const signer_1 = require("@taquito/signer");
const local_forging_1 = require("@taquito/local-forging");
const config_1 = require("./config");
const operationFlow = () => __awaiter(void 0, void 0, void 0, function* () {
    const Tezos = new taquito_1.TezosToolkit(config_1.env.rpc);
    const signer = new signer_1.InMemorySigner(config_1.env.secretKey);
    Tezos.setSignerProvider(signer);
    const estimate = yield Tezos.estimate.transfer({ to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L', amount: 1 });
    console.log(`Estimates for the transfer operation: `);
    console.log(`Fee: ${estimate.suggestedFeeMutez}`);
    console.log(`Gas limit: ${estimate.gasLimit}`);
    console.log(`Storage limit: ${estimate.storageLimit} \n`);
    const prepare = yield Tezos.prepare.transaction({
        to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L',
        amount: 1,
        fee: estimate.suggestedFeeMutez,
        gasLimit: estimate.gasLimit,
        storageLimit: estimate.storageLimit
    });
    console.log(`Prepared operation: `);
    console.log(`${JSON.stringify(prepare, null, 2)} \n`);
    const forgeableOperation = yield Tezos.prepare.toForge(prepare);
    const forger = new local_forging_1.LocalForger();
    console.log(`Forging operation...`);
    const forgedOp = yield forger.forge(forgeableOperation);
    console.log(`Forged operation: ${forgedOp} \n`);
    console.log(`Signing operation...`);
    const signedOp = yield Tezos.signer.sign(forgedOp, new Uint8Array([3]));
    console.log(`Signed operation: ${JSON.stringify(signedOp)} \n`);
    console.log(`Injecting operation...`);
    const op = yield Tezos.rpc.injectOperation(signedOp.sbytes);
    console.log(`opHash: ${op}`);
});
operationFlow();
