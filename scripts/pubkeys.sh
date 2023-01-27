#!/bin/bash
## Name:    Pubkey retrieve
## Author:  arix@ser.gal
## Purpose: Get pubkeys from github!

if [ ! -d ~/.ssh ]; then
    echo '~/.ssh does not exist, creating directory.'
    mkdir ~/.ssh
fi
echo "Replacing ~/.ssh/authorized_keys with https://github.com/$GH_USER.keys"
if ! curl -sS https://github.com/$GH_USER.keys -o ~/.ssh/authorized_keys; then
  echo 'Failed to set authorized keys!'
fi

