################################################################################
#!/bin/bash
## Name:    kcron.sh                                                          ##
## Author:  arix@ser.gal                                                      ##
## Purpose: Add key refresh script to crontab                                 ##
################################################################################

#### The following variables may be provided.

# GH_KEY_SCRIPT_PATH
# The script that gets inserted into and called from the user's crontab.
# If not provided, the default of ~/.ssh/github_key_pull.sh will be used.
# If provided WITH the content variable, then the content will overwrite this file.
# If provided WITHOUT the content variable, this file will be used as-is.

# GH_KEY_SCRIPT_CONTENT
# If provided, will overwrite the script file.
# If not provided, then the script path (either default or explicit) will be
# checked for existence. If it that not exist, the script will fail.

# Default path
if [ -z "$GH_KEY_SCRIPT_PATH" ]; then
    GH_KEY_SCRIPT_PATH=$HOME/.ssh/github_key_pull.sh
fi

if [ -z "$GH_KEY_SCRIPT_CONTENT" -a ! -f $GH_KEY_SCRIPT_PATH ]; then
    echo 'kcron.sh: GH_KEY_SCRIPT_CONTENT is empty and '$GH_KEY_SCRIPT_PATH' does not exist. Aborting.'
    echo 'kcron.sh: GH_KEY_SCRIPT_CONTENT is typically set to the content of keys.sh.'

elif [ -z "$GH_USER" ]; then
    echo 'kcron.sh: Refusing to run, variable GH_USER is empty.'

else
    # Make dir
    if [ ! -d `dirname ${GH_KEY_SCRIPT_PATH}` ]; then
        echo "kcron.sh: Creating `dirname ${GH_KEY_SCRIPT_PATH}` directory"
        mkdir -p `dirname ${GH_KEY_SCRIPT_PATH}`
    fi

    # Set script content if provided
    if [ ! -z "$GH_KEY_SCRIPT_CONTENT" ]; then
        echo "$GH_KEY_SCRIPT_CONTENT" > $GH_KEY_SCRIPT_PATH
    fi

    # Make executable
    chmod +x $GH_KEY_SCRIPT_PATH
    
    # Add to crontab (unique)
    (crontab -l; echo "0 */4 * * * GH_USER='$GH_USER' $GH_KEY_SCRIPT_PATH") | sort -u | crontab -
    if [ $? -eq 0 ]; then
        echo "kcron.sh: Inserted '0 */4 * * * GH_USER='$GH_USER' $GH_KEY_SCRIPT_PATH' into cron jobs"
    else
        echo "kcron.sh: Failed to update cron job!"
    fi

    # Also execute it once
    GH_USER=$GH_USER $GH_KEY_SCRIPT_PATH
fi
