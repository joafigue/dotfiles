#!/bin/bash
################################################################################
#
# File:         set_config.bash
# Abstract:     This File sets all files in dotfiles to their corresponding
#               location in $HOME
# Author:       Joaquin Figueroa
# Created:      Sat May 25 16:52:29 CLT 2013
# Language:     Shell script
# Description:  This file searchs for the "dotfiles" project folder, then
#               for each of the configuration files in it will create
#               the corresponding symbolic link.
#               If there is a file in the target location, this script will
#               move_it to a backup folder
#               $HOME/.backup_dotfiles/Date/{oldfiles.back}
#
################################################################################

function check_dir() {

SOURCE="${BASH_SOURCE[0]}"
Script_name=$(basename $SOURCE)
Script_dir=$(dirname $SOURCE)
Current_dir="$(pwd -L)"
Current_dir_p="$(pwd -P)"

Script_dir=$(echo $Script_dir | sed 's:\(./\)\(.*\):\2:')

if [ ! -e $Current_dir/$Script_name ] ;then
    echo You must run the script from its directory
    echo Try running the script in $Current_dir/$Script_dir 
    return 0
fi 
    
## echo Script directory $Script_dir
## echo Script name $Script_name
## echo $(ls $Script_dir | grep -m 1 "$Script_name")
## echo $(ls $Current_dir | grep -m 1 "$Script_name")

if [ $Current_dir != $Current_dir_p ] ;then
    echo The Script has to be run from its root directory
    echo This Directory is a Symbolic link to the script location
    echo Try running the Script through $Current_dir_p instead
    return 0
fi
    return 1

}

check_dir
res0=$(check_dir)
res0=$?
if [ $res0 == 1 ] ;then
    echo great success
else
    echo Poor success
    echo Damn
fi
