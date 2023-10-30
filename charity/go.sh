#!/usr/bin/env zsh
#
# Trivial zsh command-line helpers for Tezos Smart Contract development.
#

source ../go.sh
source ../sc-helpers.sh

compile_contract() { _compile_contract charity.mligo; }
alias cco=compile_contract

run_tests_taq() { _run_tests_taq charity.test.mligo; }
alias rtt=run_tests_taq

run_tests_ligo() { _run_tests_ligo charity.test.ligo; }
alias rtl=run_tests_ligo