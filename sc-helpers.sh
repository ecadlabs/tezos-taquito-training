#!/usr/bin/env zsh
#
# Helpers for Smart Contract development.

# Utility address
export addr1="tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb"

install_plugins() {
    taq install @taqueria/plugin-ligo
}

_compile_contract() { taq compile $1; }
_run_tests_taq() { taq test $1 --plugin @taqueria/plugin-ligo; }
_run_tests_ligo() { ligo run test $1; }
