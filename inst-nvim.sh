#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")

if hash nvim 2>/dev/null; then
  sudo pacman -S --noconfirm nvim 
fi

INIT_VIM='~/.config/nvim/init.vim'

if [[ -f $INIT_VIM ]]; then
	read -p "$INIT_VIM already exists, overwrite? [yN]" -n 1 -r
	if [[ $REPLY != ^[Yy]$ ]]; then
		echo "Exiting script..."
		exit
	fi
fi

echo "Curling vim-plug setup file"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Moving init.vim to $INIT_VIM"
mkdir -p ~/.config/nvim/{config,undo,.swapfiles,viminfo}
chmod +x ./update-nvim.sh && ./update-nvim.sh

nvim +PlugInstall
nvim "+CocInstall coc-{html,json,java,python,css,yank}"

if hash pip3 2>/dev/null; then
  echo "Installing pynvim..."
  pip3 install --user pynvim
  nvim +UpdateRemotePlugins
else
  echo "No pip3 bin found, pynvim required for denite"
fi

if hash npm 2>/dev/null; then
  echo "Installing node neovim..."
  npm i -g neovim
  nvim +UpdateRemotePlugins
else
  echo "No npm bin found for npm -> neovim"
fi

nvim "+call coc#util#build()"
