#!/bin/bash

if hash nvim 2>/dev/null; then
	echo "Neovim installed, continuing..."
else
	echo "Neovim not installed"
	echo "   Try `sudo [pacman|apt|yum] install neovim` etc"
	echo "Exiting..."
	exit
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
cd nvim
mkdir -p ~/.config/nvim/{plugged,config,undo,.swapfiles,viminfo}
cp init.vim ~/.config/nvim
cp ../config/*.vim ~/.config/nvim/config

nvim +PlugInstall
nvim "+CocInstall coc-{html,json,java,python,css,yank}"

if hash pip3 2>/dev/null; then
  echo "Installing pynvim..."
  pip3 install --user pynvim
  nvim +UpdateRemotePlugins
else
  echo "No pip3 bin found, pynvim required for denite"
fi

nvim "+call coc#util#build()"
