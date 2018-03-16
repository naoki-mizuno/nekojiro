#!/bin/bash

_make_alias() {
    local s="$1"
    local d="$2"
    git config --global alias.$s "$d"
}

_make_alias 'a' 'add'
_make_alias 'b' 'branch'
_make_alias 'c' 'commit'
_make_alias 'ca' 'commit --amend'
_make_alias 'co' 'checkout'
_make_alias 'cob' 'checkout -b'
_make_alias 'cop' 'checkout -p'
_make_alias 'cp' 'cherry-pick'
_make_alias 'd' 'diff'
_make_alias 'dc' 'diff --cached'
_make_alias 'f' 'fetch'
_make_alias 'l' 'log'
_make_alias 'la' 'log --all --graph'
_make_alias 'lg' 'log --graph'
_make_alias 'm' 'merge --no-ff'
_make_alias 'mt' 'mergetool'
_make_alias 'pom' 'push origin master'
_make_alias 'pl' 'pull'
_make_alias 'plum' 'pull upstream master'
_make_alias 'pom' 'push origin master'
_make_alias 'r' 'reset'
_make_alias 'rem' 'remote'
_make_alias 's' 'status'
_make_alias 'st' 'stash'
_make_alias 'sh' 'show'
git config --global credential.helper cache
