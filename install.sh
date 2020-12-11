#!/usr/bin/env bash

sudo ln -s "$HOME" /home-link
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

command -v pip3 && pip3 install --user --upgrade pynvim compiledb
command -v pip2 && pip2 install --user --upgrade pynvim

command -v gem && gem install neovim

command -v go && \
  go get -u golang.org/x/tools/gopls \
  go get -u github.com/juliosueiras/terraform-lsp

command -v npm && npm i -g \
  npm yarn neovim \
  {vim,bash}-language-server \
  dockerfile-language-server-nodejs \
  markdownlint{,-cli}

./neovim-from-source.sh
./softlink-config.sh
# curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
#        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

run_vim_cmd() {
  "$HOME/.local/bin/nvim" -u "$HOME/.config/nvim/config/plugins.vim" -c "$1"
}

run_vim_cmd "PlugInstall | qall"
run_vim_cmd "TSInstall all | qall"
run_vim_cmd "TSUninstall markdown json | qall"

FZF_PREVIEW_SCRIPT="$HOME/.local/share/nvim/plugged/fzf.vim/bin/preview.sh"
[[ -f "$FZF_PREVIEW_SCRIPT" ]] && \
  sed -i 's/REVERSE=.*/REVERSE="\\x1b\[3m\\x1b\[1m/' "$FZF_PREVIEW_SCRIPT"
