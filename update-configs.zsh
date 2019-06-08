#!/bin/zsh

[[ "$#" == "0" ]] && echo "Please specify \"in\" or \"out\"..." && exit 1

if [[ "$1" == "out" ]]; then
	cp nvim/init.vim ~/.config/nvim/
	cp nvim/coc-settings.json ~/.config/nvim/
	cp -r config ~/.config/nvim
	cp -r addit-lang-servers ~/.config/nvim
elif [[ "$1" == "in" ]]; then
	cp ~/.config/nvim/init.vim nvim/
	cp ~/.config/nvim/coc-settings.json nvim/
	cp ~/.config/nvim/config/* config
	cp -r ~/.config/nvim/addit-lang-servers/ .
fi
