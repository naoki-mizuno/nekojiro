#!/bin/bash

source scripts/utils.bash

if ! _is_installed zsh; then
    _install zsh
fi

for f in $PWD/resources/zsh/*; do
    ln -s $f ~/."$( basename $f )"
done

chsh -s $( which zsh )
