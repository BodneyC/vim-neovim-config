#!/bin/bash

soft_link() {
	[[ -f "$(realpath "$1")" ]] \
		&& ln -s "$(realpath "$1")" "$(realpath "$2")"
}

mkdir -p ~/.config/{nvim,coc}

if [[ "$1" == "-f" ]]; then
	rm -r ~/.config/{nvim,coc}
fi

mkdir -p ~/.config/{nvim,coc}

soft_link nvim/init.vim          ~/.config/nvim/init.vim
soft_link nvim/coc-settings.json ~/.config/nvim/coc-settings.json
soft_link ftplugin/              ~/.config/nvim/ftplugin
soft_link config                 ~/.config/nvim/config
soft_link addit-lang-servers     ~/.config/nvim/addit-lang-servers
soft_link nvim/package.json      ~/.config/coc/extensions/package.json
