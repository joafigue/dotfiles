#!/bin/bash

# Taken from
#https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
function get_session_name() {
    if [ -z ${TMUX_SESSION+x} ]; then
        echo "default"
    else
        echo "${TMUX_SESSION}"
    fi
}

# Taken from
# https://stackoverflow.com/questions/1510481/how-can-i-detect-that-emacs-server-is-running-from-a-shell-prompt
function daemon_running() {
    SESSION=$(get_session_name)
    emacsclient -a false -e 't' -s "${SESSION}" 2> /dev/null
}

function edaemon() {
    SESSION=$(get_session_name)
    emacs --daemon="${SESSION}"
}

function noemacs() {
    SESSION=$(get_session_name)
    if test "$(daemon_running)" ; then
        emacsclient --eval '(kill-emacs)' -s "${SESSION}"
        echo "Killing emacs for session ${SESSION}"
    else
        echo "Emacs not running"
    fi
}

function emf() {
    SESSION=$(get_session_name)
    test "$(daemon_running)" || edaemon
    emacsclient -c -n -s "${SESSION}" "${@}"
}

function em() {
    SESSION=$(get_session_name)
    test "$(daemon_running)" || edaemon
    emacsclient -t -s "${SESSION}" "${@}"
}

# EDITOR="em"
# VISUAL="emf"
