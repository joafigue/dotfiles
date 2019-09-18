#! /bin/zsh -f
export PS1='[%n@%m %~]$ '

common_source="${HOME}/.Shell_common/posix.sh"
[[ -f ${common_source}  ]] && . ${common_source}
