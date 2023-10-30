#!/usr/bin/env zsh
#
# Zsh command-line helpers for Tezos Smart Contract development.
#

source ../go.sh
source ../sc-helpers.sh

compile_contract() { _compile_contract counter.mligo; }

run_tests_taq() { _run_tests_taq memory.test.mligo; }
alias rtt=run_tests_taq

run_tests_ligo() { _run_tests_ligo memory.test.ligo; }
alias rtl=run_tests_ligo
