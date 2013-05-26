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
## executable name
    SOURCE="${BASH_SOURCE[0]}"
    Script_name=$(basename $SOURCE)
    Script_dir=$(dirname $SOURCE)
    Current_dir="$(pwd -L)"
    Current_dir_p="$(pwd -P)"

    Script_dir=$(echo $Script_dir | sed 's:\(./\)\(.*\):\2:')
    ## Check if run from the script directory
    if [ ! -e $Current_dir/$Script_name ] ;then
        echo You must run the script from its directory
        echo Try running the script in $Current_dir/$Script_dir
        exit 0
    fi
    ## Check if the script directory is not a symbolic link
    if [ $Current_dir != $Current_dir_p ] ;then
        echo The Script has to be run from its root directory
        echo This Directory is a Symbolic link to the script location
        echo Try running the Script through $Current_dir_p instead
        exit 0
    fi
    return 1
}

function files_config() {
    ## Associative array with the files in the project
    declare -g -A files
    files[bashrc]="shell/Shell_common/posix.sh .bashrc"
    files[bash_logout]="shell/bash/bash_logout.bash .bash_logout"
    files[bash_profile]="shell/bash/bash_profile.bash .bash_profile"

    files[zshrc]="shell/Shell_common/posix.sh .zshrc"

    files[conkeror]="browser/conkeror_configs/conkerorrc.js .conkerorrc"

    files[Xresources]="X11_config/Xresources .Xresources"

    files[Xmonad]="xmonad/xmonad.hs .xmonad/xmonad.hs"

}

function create_backups() {
    # check if target backup directory exists
    backup=".backup_dotfiles"
    date="$(date +%F)_$(date +%s)"
    Backup=$HOME/$backup/$date
    if [ ! -d $HOME/$backup ] ; then
        echo Backup parent directory does not exist
        echo Creating backup parent $HOME/$backup
        mkdir $HOME/$backup
    fi
    echo Creating backup directory $Backup
    mkdir $Backup

    ## Check if files in project exist in target location
    ## If they do move them to backup destination
    for i in "${!files[@]}"
    do
        data=(${files[$i]})
        if [ -e $HOME/${data[1]} ] ;then
            echo $i: Target file exists
            echo Moving $HOME/${data[1]} to $Backup/$i\.back
            mv $HOME/${data[1]} $Backup/$i\.back
        fi
    done

}

function create_symlinks() {
    ## For every file in the array create the symbolic link to target destination
    echo "************"
    DIR=$(pwd -P)
    for i in "${!files[@]}"
    do
        data=(${files[$i]})
        orig=$DIR/${data[0]}
        dest=$HOME/${data[1]}
        cmd="ln -s $orig $dest"
        echo Creating symbolic link for $i
        echo $cmd
        $cmd
    done

}

function main() {
    ## Main loop
    check_dir
    files_config
    create_backups
    create_symlinks
}

main 
