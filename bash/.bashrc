export HISTCONTROL=ignoreboth:erasedups
PS1='[\u@\h \W]\$ '

common_source="${HOME}/.Shell_common/posix.sh"
[[ -f ${common_source}  ]] && source ${common_source}

# Increase history
shopt -s histappend
# Bigger history without duplicates
export HISTSIZE=5000
export HISTCONTROL=ignoreboth:erasedups
# Do not store single/double/tripple letter commands
export HISTIGNORE="?:??:???:$HISTIGNORE"

# Notice that tac comes from coreutils, it's basically reverse cat
function clean_history(){
    tac ~/.bash_history | awk '!seen[$0]++' | tac > .tmp.newhist && mv .tmp.newhist ~/.bash_history
}
