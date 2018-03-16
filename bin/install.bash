#!/bin/bash

if (( $# != 0 )); then
    PACKAGES=( $@ )
else
    PACKAGES=( vim emacs zsh git )
fi

_exec_setup() {
    local package="$1"

    source scripts/utils.bash

    if [[ -x scripts/setup_${package}.bash ]]; then
        _echo_info "Setting up ${package}"
        bash "scripts/setup_${package}.bash"

        if (( $? == 0 )); then
            _echo_success "Done!"
        else
            _echo_error "Failed setting up ${package}"
        fi
    else
        _echo_error "scripts/setup_${package}.bash not found"
    fi
}

for package in ${PACKAGES[@]}; do
    SOURCE_DIR="$( readlink "$BASH_SOURCE" )"
    SOURCE_DIR="${SOURCE_DIR:-$BASH_SOURCE}"
    ( cd "$( dirname "$SOURCE_DIR" )/.." && _exec_setup "$package" )
done
