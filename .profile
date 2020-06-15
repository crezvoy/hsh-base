#! /bin/sh

if [ -d "$HOME/.config/profile" ] 
then
    for entry in $(ls -1 "$HOME/.config/profile")
    do
        . "$HOME/.config/profile.d/$entry"
    done
fi

PATH=$HOME/bin:$PATH

export PATH



