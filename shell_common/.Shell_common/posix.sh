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

SHELL_COMMON="${HOME}/.Shell_common"

## Source configuration files by functionality
source $SHELL_COMMON/shell_functions.sh
source $SHELL_COMMON/emacs_functions.sh
source $SHELL_COMMON/alias.sh

## Clear variables
unset SHELL_SOURCES
unset SHELL_COMMON
unset SPECIFIC_SOURCES


alias semf="emacs &"
alias sem="emacs -nw"
