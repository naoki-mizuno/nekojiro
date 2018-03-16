#!/bin/bash

source scripts/utils.bash

if ! _is_installed emacs24-nox; then
    _install emacs24-nox
fi

mkdir -p ~/.emacs
ln -s $PWD/resources/init.el ~/.emacs/init.el
