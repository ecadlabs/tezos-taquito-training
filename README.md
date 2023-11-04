# Tezos Taquito Training

## Introduction

This repository serves as a training ground for learning how to use the [Taquito](https://tezostaquito.io/) library to interact with the Tezos blockchain.

It includes simple and relevant examples to get started with leraning Taquito and Tezos.

## Getting Started

### Prerequisites
- [Node.js](https://nodejs.org/en/) (version 16 or higher, v18 LTS recommended)
- NPM

### Installation
```
npm install
```

### Running an examples
- more scripts in `package.json` file
```
npm run get-block-header
```

## Generating your secret key

To generate your secret key, we have provided a script `key-gen.ts`

Execute the script using this command:
```
npm run keygen
```

This will generate a file called `key.json` that contains the following:
- public key hash
- secret key
- public key

***Attention*:**
These need to be kept safe, and are for **your** eyes only. Secret keys are what uniquely identify us on the blockchain. Losing them might lead to you losing control of your assets, or someone impersonating you.

