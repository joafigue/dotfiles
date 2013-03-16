#! /bin/bash
################################################################################
#
# File:         posix.sh
# Abstract:     Generic Shell file for BASH/ZSH configurations
# Author:       Joaquin Figueroa
# Created:      Sun Mar  3 16:21:00 CLST 2013
# Language:     Shell script
# Description:  This file hold minimum configurations that are common to either
#               BASH or ZSH interactive shells.
#               Also provides a Common point for sourcing the specific
#               configurations
#
################################################################################


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

SHELL_SOURCES=$(echo $(ls $HOME -al | grep -m 1 posix.sh ) | sed 's:.*->.\(.*\)\(/Shell_common/posix.sh\).*:\1:')
SHELL_COMMON=$SHELL_SOURCES/Shell_common

## Source configuration files by functionality
source $SHELL_COMMON/shell_functions.sh
source $SHELL_COMMON/emacs_functions.sh
source $SHELL_COMMON/alias.sh

MY_SHELL=$(which_shell)
SPECIFIC_SOURCES=$SHELL_SOURCES/$MY_SHELL
source $SPECIFIC_SOURCES/${MY_SHELL}.${MY_SHELL}

## Clear variables
unset SHELL_SOURCES
unset SHELL_COMMON
unset SPECIFIC_SOURCES


EDITOR="emacsclient -t"
VISUAL="emacsclient -c"


alias edaemon="emacs --daemon"
alias noemacs="emacsclient --eval '(kill-emacs)'"


alias emf="emacsclient -c -n"
alias em="emacsclient -t"
alias semf="emacs &"
alias sem="emacs -nw"
