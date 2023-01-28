#!/bin/bash
################################################################################
## Name:    keys.sh                                                           ##
## Author:  arix@ser.gal                                                      ##
## Purpose: Get pubkeys from github!                                          ##
################################################################################

if [ -z "$GH_USER" ]; then
    echo 'Refusing to execute keys.sh. GH_USER is empty.'
else
    if [ ! -d ~/.ssh ]; then
        echo '~/.ssh does not exist, creating directory.'
        mkdir ~/.ssh
    fi
    echo "Replacing ~/.ssh/authorized_keys with https://github.com/$GH_USER.keys"
    if ! curl -sS https://github.com/$GH_USER.keys -o ~/.ssh/authorized_keys; then
      echo 'Failed to set authorized keys!'
    fi
fi
