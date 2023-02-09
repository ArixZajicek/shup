################################################################################
#!/bin/bash
## Name:    keys.sh                                                           ##
## Author:  arix@ser.gal                                                      ##
## Purpose: Get pubkeys from github!                                          ##
################################################################################

if [ -z "$GH_USER" ]; then
    echo "keys.sh: Refusing to run, variable GH_USER is empty."
else
    if [ ! -d ~/.ssh ]; then
        echo "keys.sh: Creating ~/.ssh directory"
        mkdir ~/.ssh
    fi

    # Make sure we can get the current keys first, otherwise we will want to fail the operation.
    RETRIEVED_KEYS=`curl -sS https://github.com/$GH_USER.keys`
    if [ $? -eq 0 ]; then
        if [ -f ~/.ssh/authorized_keys ]; then
            PRIOR_FILTERED_KEYS=`grep --ignore-case --invert-match "# GITHUB USER \"$GH_USER\"" ~/.ssh/authorized_keys`
        fi
        (echo "$PRIOR_FILTERED_KEYS"; echo "$RETRIEVED_KEYS" | sed --expression "s/$/ # GITHUB USER \"$GH_USER\"/") > ~/.ssh/authorized_keys
        echo "keys.sh: Public keys from GitHub user $GH_USER successfully refreshed!"
    else
        echo "keys.sh: Failed to retrieve GitHub keys for user $GH_USER! Aborting changes."
    fi
fi
