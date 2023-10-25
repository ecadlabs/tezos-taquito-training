#!/usr/bin/env zsh
#
# Generic zsh routines/helpers for development and scripting
# Routines prepended with underscores are not usually called directly.

alias -g CUR_FUN='${(%):-%N}' # Just the name of the currently executing function

_err() { # write a (loud) message to stderr, if running interacively
    [[ -o interactive ]] && tput setaf 1
    echo $fail_char "$@" 1>&2
}
