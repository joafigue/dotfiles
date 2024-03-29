#!/bin/bash

function which_shell() {
    local my_shell=""
    if [ $BASH_VERSION ]; then
        my_shell=bash
    elif [ $ZSH_VERSION ]; then
        my_shell=zsh
    fi
    echo $my_shell
}

function rload() {
    local shell=$(which_shell)
    echo $HOME/.${shell}rc
    source  $HOME/.${shell}rc
}


function colors(){
#/bin/bash
#
#   This file echoes a bunch of color codes to the
#   terminal to demonstrate what's available.  Each
#   line is the color code of one forground color,
#   out of 17 (default + 16 escapes), followed by a
#   test use of that color on all nine background
#   colors (default + 8 escapes).


T='gYw'   # The test text

echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m";

for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
               '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
               '  36m' '1;36m' '  37m' '1;37m';
  do FG=${FGs// /}
      echo -en " $FGs \033[$FG  $T  "
        for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
            do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
              done
          echo;
          done
echo
}

function clear_whitespace() {
find . -name '* *' | while read file;
do
target=`echo "$file" | sed 's/ /_/g'`;
echo "Renaming '$file' to '$target'";
mv "$file" "$target";
done;

}

lisp() {
    guile -c '(display '"${@}"')'
    guile -c '(display "\n")'
}

function tm() {
  # Maybe there is a whitespace problem, but I dont use
  # whitespaces in directory names so is a non-issue
  TMUX_SESSION=$(basename "$(pwd)")
  tmux new -A -s "${TMUX_SESSION}" -e "TMUX_SESSION=${TMUX_SESSION}"
}
