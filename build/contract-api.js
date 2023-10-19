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
const transactionOperation = () => __awaiter(void 0, void 0, void 0, function* () {
    console.log(`Transferring funds...`);
    const op = yield Tezos.contract.transfer({
        to: 'tz1YvE7Sfo92ueEPEdZceNWd5MWNeMNSt16L',
        amount: 0.01
    });
    console.log(`Awaiting confirmation...`);
    yield op.confirmation();
    console.log(`Operation hash: ${op.hash}`);
    // check transaction result using indexer: 
});
const callContract = () => __awaiter(void 0, void 0, void 0, function* () {
    const contractAddress = 'KT1DY97sFj5TZY7s3BhMeydRSV7PS19nzxAG';
    console.log(`Calling contract at address: ${contractAddress}`);
    const contract = yield Tezos.contract.at(contractAddress);
    const op = yield contract.methods.default(5).send();
    yield op.confirmation();
    console.log(`Contract updated at address: ${contractAddress}`);
    console.log(`Operation hash: ${op.hash}`);
    // check contract call result using indexer: https://ghostnet.tzkt.io/KT1DY97sFj5TZY7s3BhMeydRSV7PS19nzxAG/operations/
});
transactionOperation();
