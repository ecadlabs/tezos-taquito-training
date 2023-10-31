#!/usr/bin/env zsh
#
# Zsh command-line helpers for Tezos Smart Contract development.
#
source ../go.sh
source ../sc-helpers.sh

compile_contracts() {
    _compile_contract counter.mligo
    # TODO Update to new ligo version!
    # _compile_contract memory.mligo
}
alias ccs=compile_contracts

# Taqueria looks for contracts in `contracts/`
run_tests_taq() {
    _run_tests_taq memory.test.mligo
    _run_tests_taq counter.test.mligo
}
alias rtt=run_tests_taq

# Substantially faster than `run_tests_taq` but not as pretty; notice full path req'd
run_tests_ligo() {
    _run_tests_ligo contracts/counter.test.mligo
    _run_tests_ligo contracts/memory.test.mligo
}
alias rtl=run_tests_ligo

# See https://is.gd/Fxf7SF for more info
dry_run_counter() {
    ligo run dry-run -m IncDec contracts/counter.mligo "Increment(5)" 5
}

# See https://is.gd/TITQBc for more info
compile_counter_storage() {
    # This just emits `42`, because the storage is just an `int`; of course, storage is usually
    # more complex than this, usually involving a data structure with nested lists, maps, etc.
    ligo compile storage contracts/counter.mligo 42
}

compile_counter_parameter() {
    ligo compile parameter contracts/counter.mligo 'Increment(5)'
}
