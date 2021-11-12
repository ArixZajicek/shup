

# Set Aliases
alias ll='ls -al'

# Custom prompt
if [ "$EUID" -ne 0 ] ; then
    export PS1="\[\033[38;5;7m\][\[$(tput sgr0)\]\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;8m\]@\[$(tput sgr0)\]\[\033[38;5;6m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;8m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
else
    export PS1="[\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;9m\]\u\[$(tput sgr0)\]\[\033[38;5;8m\]@\[$(tput sgr0)\]\[\033[38;5;6m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\]] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;9m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
fi

# Make ls work better with ntfs filesystems (and most highlighting is bad anyway)
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=0;34:ow=0;34:st=0;34:ex=01;32:';

