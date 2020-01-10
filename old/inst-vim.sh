#!/bin/bash

if [[ -f ~/.vimrc ]]; then
	read -p "\$HOME/.vimrc already exists, overwrite? [yn]" -n 1 -r
	if [[ $REPLY != ^[Yy]$ ]]; then
		echo "Exiting script..."
		exit
	fi
fi

echo "Curling vim-plug setup file"
curl -fLo ~/.vim/autoload/plug.vim \
	--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Moving .vimrc to ~/"
cp .vimrc ~
mkdir -p ~/.vim/{config,undo,swapfiles,viminfo}
cp config/*.vim ~/.vim/config

vim +PlugInstall
