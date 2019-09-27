#!/bin/bash

# shellcheck disable=SC2230

cd "$HOME/gitclones" || exit

[[ ! -d neovim ]] && git clone https://github.com/neovim/neovim.git

cd neovim || exit

git checkout master
git pull

make CMAKE_INSTALL_PREFIX="$(realpath ~/.local)"

NVIM_PATH=$(which nvim)
[[ -n "$NVIM_PATH" ]] && cp "$NVIM_PATH"{,.BAK}

make install
