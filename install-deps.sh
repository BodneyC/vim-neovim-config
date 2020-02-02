#!/usr/bin/env bash

if hash npm; then
  npm i -g \
    yarn \
    neovim \
    vim-language-server \
    bash-language-server \
    dockerfile-language-server-nodejs \
    markdownlint \
    markdownlint-cli
fi

if hash pip3; then
  pip3 install --user --upgrade \
    pynvim \
    neovim \
    libtmux \
    tmux_dash
fi

if hash pip2; then
  pip2 install --user --upgrade pynvim
fi

if hash gem; then
  gem install neovim
fi

if hash pacman; then
  ! hash xclip && sudo pacman -S --no-confirm xclip
fi
