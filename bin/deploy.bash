#!/bin/bash

DEST=$HOME/usr/share/nekojiro

if [[ -d $DEST ]]; then
    exit
fi

git clone https://github.com/naoki-mizuno/nekojiro "$DEST"

bash "$DEST/bin/install.bash"
