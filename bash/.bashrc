export HISTCONTROL=ignoreboth:erasedups
PS1='[\u@\h \W]\$ '

common_source="${HOME}/.Shell_common/posix.sh"
[[ -f ${common_source}  ]] && source ${common_source}
