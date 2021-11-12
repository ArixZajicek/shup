<?php
	header("Content-Type: text/x-shellscript");
?>

#!/bin/bash
## Name:    SHell setUP
## Author:  ArixZajicek
## Purpose: Quickly set up any linux environment with personally
##      prefered aliases and configurations. Will also update with root configs
##      if the user has sudo privileges.

# Path to site
remotepath="https://arix.cc/shup"

function addscript() {
    # Base path for configs (usually home dir)
    local basepath=$1

    echo "Downloading .nanorc and .bash_aliases into $basepath..."

    # Always download the same bash aliases script
    wget $remotepath/.bash_aliases --no-check-certificate -q -O $basepath/.bash_aliases

    # .nanorc can have different colors for the root user
    if [ "$basepath" = "/root" ]; then
        wget $remotepath/.nanorc_root --no-check-certificate -q -O $basepath/.nanorc
    else
        wget $remotepath/.nanorc --no-check-certificate -q -O $basepath/.nanorc
    fi

    # Create .bashrc if it does not exist
    touch $basepath/.bashrc

    # Include bash_aliases if not mentioned (and uncommented) in bashrc
    grep -E "^[^#]?+.bash_aliases" ~/.bashrc > /dev/null
    if [ $? -ne 0 ] ; then
        echo "Adding '. ~/.bash_aliases' to $basepath/.bashrc"
        echo '. ~/.bash_aliases' >> $basepath/.bashrc
    fi

    # Source new bash_aliases if we're the active user
    if [ "$basepath" = "$HOME" ] ; then
        source $HOME/.bash_aliases
    fi
}

addscript $HOME

#Repeat all if user has sudo privileges and responds with yes
if groups | grep -E "wheel|sudo" > /dev/null && [ $EUID -ne 0 ] ; then
    echo "You appear to have sudo privileges."
	read -r -p "Would you like to apply configs to the root user? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
		echo "Applying configs for root user."
		sudo bash -c "$(declare -f addscript); addscript /root"
    fi
fi
