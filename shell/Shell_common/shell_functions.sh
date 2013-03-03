function which_shell() {
    local my-shell=""
    if [ $BASH_VERSION ]; then
	my_shell=bash
    elif [ $ZSH_VERSION ]; then
	my_shell=zsh
    fi
    echo $myshell
}

function rload() {
local shell=$(which_shell)
echo $HOME/.${shell}rc
source  $HOME/.${shell}rc
}
