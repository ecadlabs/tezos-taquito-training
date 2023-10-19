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
const config_1 = require("./config");
const Tezos = new taquito_1.TezosToolkit(config_1.env.rpc);
const signer = new signer_1.InMemorySigner(config_1.env.secretKey);
Tezos.setSignerProvider(signer);
const batchOperation = () => __awaiter(void 0, void 0, void 0, function* () {
    // 1st syntax
    const batchOp = yield Tezos.contract
        .batch()
        .withTransfer({ to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L', amount: 0.02 })
        .withTransfer({ to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L', amount: 0.02 });
    const op = yield batchOp.send();
    console.log(op);
    yield op.confirmation();
});
const batchOperation2 = () => __awaiter(void 0, void 0, void 0, function* () {
    // 2nd syntax
    const batchOp = yield Tezos.contract
        .batch([
        { kind: taquito_1.OpKind.TRANSACTION, to: 'tz1ZfrERcALBwmAqwonRXYVQBDT9BjNjBHJu', amount: 0.02 },
        { kind: taquito_1.OpKind.TRANSACTION, to: 'tz1ZfrERcALBwmAqwonRXYVQBDT9BjNjBHJu', amount: 0.02 },
    ])
        .send();
    yield batchOp.confirmation();
    console.log(batchOp);
});
// batchOperation();
