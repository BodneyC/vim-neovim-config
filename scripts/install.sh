#!/usr/bin/env bash

_sdir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

cd "$_sdir/.." || {
  echo "Couldn't cd to repo dir"
  exit 1
}

sudo pacman -S \
  xclip ripgrep jq bat exa \
  zenity \
  python{,2}-pip \
  nodejs npm \
  ruby{,gems} \
  go \
  shellcheck \
  ccls

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

command -v rustup && rustup component add rls rust-{analysis,src}

command -v pip3 && pip3 install --user --upgrade neovim compiledb
command -v pip2 && pip2 install --user --upgrade neovim

command -v gem && gem install neovim

command -v go \
  && go get -u golang.org/x/tools/gopls \
    go get -u github.com/juliosueiras/terraform-lsp

command -v npm && npm i -g \
  npm yarn neovim \
  typescript \
  {vim,bash,typescript}-language-server \
  dockerfile-language-server-nodejs \
  markdownlint{,-cli}

"$_sdir/neovim-from-source.sh"
"$_sdir/softlink-config.sh"

run_vim_cmd() {
  "$HOME/.local/bin/nvim" -u "$HOME/.config/nvim/lua/cfg/plugins.vim" -c "$1"
}

run_vim_cmd "PackerInstall | qall"
run_vim_cmd "TSInstall all | qall"

"$_sdir/alter-fzf-preview.sh"
