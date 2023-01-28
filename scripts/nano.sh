#!/bin/bash
################################################################################
## Name:    nano.sh                                                           ##
## Author:  arix@ser.gal                                                      ##
## Purpose: Set up .nanorc options                                            ##
################################################################################

touch ~/.nanorc
if ! grep -q '# shup_sentinel' ~/.nanorc ; then
    echo "Adding options to ~/.nanorc"
cat >> ~/.nanorc << "EOF"
# shup_sentinel
set autoindent
unset backup
unset emptyline
unset jumpyscrolling
set linenumbers
set mouse
set positionlog
set quickblank
unset suspend
set smarthome
set softwrap
set tabsize 4
set tabstospaces
set trimblanks
set zap
EOF
    if [ "$EUID" -ne 0 ] ; then
# regular user
cat >> ~/.nanorc << "EOF"
# unprivileged colors
set titlecolor white,blue
set statuscolor white,green
set errorcolor white,red
set selectedcolor white,magenta
set stripecolor ,yellow
set numbercolor cyan
set keycolor cyan
set functioncolor green
EOF
    else
# root user
cat >> ~/.nanorc << "EOF"
# root and privileged colors
set titlecolor brightwhite,magenta
set statuscolor brightwhite,magenta
set errorcolor brightwhite,red
set selectedcolor brightwhite,cyan
set stripecolor ,yellow
set numbercolor magenta
set keycolor brightmagenta
set functioncolor magenta
EOF
    fi
else
    echo "~/.nanorc already contains #shup_sentinel, skipping update."
fi
