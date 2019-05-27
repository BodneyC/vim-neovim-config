#!/bin/zsh

[[ "$#" == "0" ]] && echo "Please specify \"in\" or \"out\"..." && exit 1

if [[ "$1" == "out" ]]; then
	cp nvim/init.vim ~/.config/nvim/
	cp -r config ~/.config/nvim
elif [[ "$1" == "in" ]]; then
	cp ~/.config/nvim/init.vim .
	cp ~/.config/nvim/config/* config
fi
