#!/usr/bin/env bash

sudo pacman -S \
  xclip \
  shellcheck \
  python{,2}-pip \
  nodejs npm \
  ruby \
  ripgrep jq bat exa

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
