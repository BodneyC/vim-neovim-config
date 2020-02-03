#!/usr/bin/env bash

### Gtags

FN="global-6.6.4"

if ! hash gtags; then
    _msg_exit() { # msg[, ret_val]
        echo "$1, exiting..."
        [[ -n "$2" ]] && exit "$2"
    }

    mkdir -p "$HOME/gitclones/gtags"
    cd "$HOME/gitclones/gtags" || _msg_exit "Could not CD to gtags dir" 1

    wget "http://tamacom.com/global/$FN.tar.gz"
    tar xzvf "$FN.tar.gz"

    cd $FN || _msg_exit "Could not CD to $FN" 1

    ./configure --prefix="$HOME/.local"
    make
    make check || _msg_exit "\`make check\` failed" 2
    make install


    ### Pygments plugin

    REPO="global-pygments-plugin"

    # shellcheck disable=SC2164
    cd "$HOME/gitclones"

    git clone "https://github.com/yoshizow/$REPO.git"
    cd "$REPO" || _msg_exit "Could not cd to $REPO" 1

    hash pip2 || _msg_exit "No pip2 binary found"

    pip2 install --user Pygments

    ./reconf.sh

    ./configure --prefix "$HOME/.local"

    make
    make install
fi
