#!/usr/bin/env bash

! test -d "$HOME/gitclones" && mkdir -p "$HOME/gitclones"
cd "$HOME/gitclones" || exit

! test -d neovim && git clone https://github.com/neovim/neovim.git
cd neovim || exit

git checkout master
git pull

# For 0.6+
git fetch --tags --all -f
# git checkout tags/nightly

# For 0.5
git checkout origin/release-0.8

unset LUA_PATH LUA_CPATH

make clean

make CMAKE_INSTALL_PREFIX="$(realpath ~/.local)" CMAKE_BUILD_TYPE=RelWithDebInfo

NVIM_PATH=$(command -v nvim)
[[ -n "$NVIM_PATH" ]] && cp "$NVIM_PATH"{,.bak}

make install
