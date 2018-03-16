#!/bin/bash

source scripts/utils.bash

if ! _is_installed vim-nox; then
    _install vim-nox
fi

mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/plugged
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/view
mkdir -p ~/.vim/undo
_get_from_url \
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
    ~/.vim/autoload/plug.vim

ln -s $PWD/resources/vimrc ~/.vimrc

vim -c 'PlugInstall | qa'
