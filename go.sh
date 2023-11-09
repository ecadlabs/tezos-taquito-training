#!/usr/bin/env zsh
#
# Zsh command-line helpers for Taquito / Tezos workshop
#

set_node_environment() {
    nvm use v18
}

# Notice the first time this is run it will return an error: `empty implicit contract`
# This indicates you need to fund the account with some tez.
run_transfer_operation() {
    npm run operation-flow
    # Here is an example of a successful run of this command:
    # https://ghost.tzstats.com/ooWwciEi8qCR31At8dEZG8WEkYbib1KYNCN4nH2R9XtHxY4dNa6
}

# Generates `key.json`, which contains a public/private keypair
run_keygen() {
    [[ -f key.json ]] || npm run keygen
    [[ -f key.json ]] || { echo 'Error: no key.json found'; return 1 }
    secret_key=$(cat key.json | jq -r '.secretKey')
    export SECRET_KEY=${secret_key}
}

# This will transfer some tez to the account hardcoded in `src/batch-api.ts`
run_batch_api() {
    npm run batch-api
}
