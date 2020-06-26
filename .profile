#! /bin/sh

if [ -d "$HOME/.config/profile" ] 
then
    for entry in $(ls -1 "$HOME/.config/profile")
    do
        . "$HOME/.config/profile/$entry"
    done
fi

export FULL_USER="Clément Rezvoy"
export EMAIL="clement.rezvoy@gmail.com"
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export WWW_HOME='http://www.ddg.gg'
export PATH=$HOME/bin:$PATH




