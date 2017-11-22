#!/bin/bash

  sshhpy=$HOME/.local/share/sshh/sshh.py

_sshh () {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local hints=$($sshhpy --list)
    COMPREPLY=( $(compgen -W "$hints" -- $cur) )
}
complete -F _sshh sshh
