#!/usr/bin/env zsh
#
# Zsh command-line helpers for the Simple Memory Game, which uses a Tezos Smart Contract implemented
# in CameLIGO, and a UI that uses Taquito to interact with the contract.
#
# * Ensure you are using `zsh` (you can check with `$ echo $SHELL`)
# * Run `$ source go.sh` to load the commands into your current shell session

source ./util.sh

# TODO Port to `devbox`?
setup_node() {
    [[ $(command -v nvm) ]] || echo 'No `nvm` found: Ensure you run Node v16.16+'
    # NOTE Node v17 is not supported!
    nvm use v16
}

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

convert_mermaid_diagrams_to_svg () {
    # `npm install -g mermaid.cli`
	  [[ -n $(command -v mmdc) ]] || { _err '`Mermaid` has not been installed' && return 1 }
	  for diagram in img/**/*.mmd; do
		    mmdc -i $diagram -o ${diagram:r}.svg
	  done
}

_convert_to_xyz() {
    [[ -f $1 ]] || { _err "File not found: $1"; return 2 }
    # `sudo apt get install imagemagick`
    [[ -n $(command -v mogrify) ]] || { _err '`ImageMagick` has not been installed'; return 3 }
    mogrify -format $2 -resize 1920x1080 -density 300 ${1:r}.${2}
}

convert_svg_to_jpg() {
    (( $# == 1 )) || { _err 'usage:' CUR_FUN '<file>'; return 1 }
    _convert_to_xyz $1 jpg
}

convert_svg_to_png() {
    (( $# == 1 )) || { _err 'usage:' CUR_FUN '<file>'; return 1 }
    _convert_to_xyz $1 png
}
