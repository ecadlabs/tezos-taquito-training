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
const initialize = () => __awaiter(void 0, void 0, void 0, function* () {
    console.log(`Call the RPC to get the current block head`);
    const header = yield Tezos.rpc.getBlockHeader();
    console.log(JSON.stringify(header, null, 2));
});
initialize();
