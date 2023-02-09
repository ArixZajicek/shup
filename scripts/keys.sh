################################################################################
#!/bin/bash
## Name:    keys.sh                                                           ##
## Author:  arix@ser.gal                                                      ##
## Purpose: Get pubkeys from github!                                          ##
################################################################################

if [ -z "$GH_USER" ]; then
    echo "Refusing to execute keys.sh. Variable GH_USER is empty."
else
    if [ ! -d ~/.ssh ]; then
        echo "~/.ssh does not exist, creating directory."
        mkdir ~/.ssh
    fi

    # Make sure we can get the current keys first, otherwise we will want to fail the operation.
    RETRIEVED_KEYS=`curl -sS https://github.com/$GH_USER.keys`
    if [ $? -eq 0 ]; then
        if [ -f ~/.ssh/authorized_keys ]; then
            PRIOR_FILTERED_KEYS=`grep --ignore-case --invert-match "# GITHUB USER \"$GH_USER\"" ~/.ssh/authorized_keys`
        fi
        (echo "$PRIOR_FILTERED_KEYS"; echo "$RETRIEVED_KEYS" | sed --expression "s/$/ # GITHUB USER \"$GH_USER\"/") | tee ~/.ssh/authorized_keys
        echo "Keys from GitHub user $GH_USER successfully updated."
    else
        echo "Failed to retrieve GitHub keys for user $GH_USER! Aborting changes."
    fi
fi
