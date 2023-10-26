#!/usr/bin/env zsh
#
# Zsh command-line helpers for Taquito / Tezos development.
#
# * Ensure you are using `zsh` (you can check with `$ echo $SHELL`)
# * Run `$ source go.sh` to load the commands into your current shell/session
#
# Methods prefixed with `_` are 'pseudo-internal' / not really for direct usage.

CURRENT_DIRECTORY=${0:a:h}  # zsh magic
source ${CURRENT_DIRECTORY}/util.sh  # Make `source go.sh` work from any directory

# TODO Trial `devbox` for this?
setup_node() {
    [[ $(command -v nvm) ]] || { _err 'No `nvm` found: Ensure you run Node v16.16+'; return 1 }
    # NOTE Node v17 is not supported by Taquito!
    nvm use v16
}

convert_mermaid_diagrams_to_svg () {
    # `npm install -g mermaid.cli`
	  [[ -n $(command -v mmdc) ]] || { _err '`Mermaid` has not been installed'; return 1 }
	  for diagram in img/**/*.mmd; do
		    mmdc -i $diagram -o ${diagram:r}.svg
	  done
}

_convert_to_xyz() {
    [[ -f $1 ]] || { _err "File not found: $1"; return 1 }
    # `sudo apt get install imagemagick`
    [[ -n $(command -v mogrify) ]] || { _err '`ImageMagick` has not been installed'; return 2 }
    mogrify -format $2 -resize 1920x1080 -density 300 ${1:r}.${2}
}

convert_svg_to_jpg() {
    (( $# != 1 )) || { _err 'usage:' CUR_FUN '<svg file>'; return 1 }
    _convert_to_xyz $1 jpg
}

convert_svg_to_png() {
    (( $# != 1 )) || { _err 'usage:' CUR_FUN '<svg file>'; return 1 }
    _convert_to_xyz $1 png
}
