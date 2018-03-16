#!/bin/bash

DEST=$HOME/usr/share/nekojiro

if ! [[ -d $DEST ]]; then
    git clone https://github.com/naoki-mizuno/nekojiro "$DEST"
fi

bash "$DEST/bin/install.bash"
