#!/bin/bash

cd "$HOME/gitclones" || exit

[[ ! -d neovim ]] && git clone https://github.com/neovim/neovim.git

cd neovim || exit

git checkout nightly
git pull

make clean

make CMAKE_INSTALL_PREFIX="$(realpath ~/.local)" CMAKE_BUILD_TYPE=RelWithDebInfo

NVIM_PATH=$(command -v nvim)
[[ -n "$NVIM_PATH" ]] && cp "$NVIM_PATH"{,.bak}

make install
