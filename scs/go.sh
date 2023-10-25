#!/usr/bin/env zsh
#
# Zsh command-line helpers for Tezos Smart Contract development.
#

source ../go.sh

install_plugins() {
    taq install @taqueria/plugin-ligo
}

_compile_contract() { taq compile $1; }
compile_counter_contract() { _compile_contract Counter.mligo; }

_run_tests() { taq test $1 --plugin @taqueria/plugin-ligo; }
_run_tests_ligo() { ligo run test $1; }

run_memory_tests_taq() { _run_tests Memory.test.mligo; }
run_memory_tests_ligo() { _run_tests_ligo Memory.test.ligo; }
alias rtl=run_tests_ligo
