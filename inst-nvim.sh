#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit

if hash nvim 2>/dev/null; then
    sudo pacman -S --noconfirm nvim shellcheck xclip
fi

INIT_VIM="$HOME/.config/nvim/init.vim"

if [[ -f $INIT_VIM ]]; then
    read -p "$INIT_VIM already exists, overwrite? [yN]" -n 1 -r
    if [[ $REPLY != ^[Yy]$ ]]; then
        echo "Exiting script..."
        exit
    fi
fi

echo "Curling vim-plug setup file"
curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Moving init.vim to $INIT_VIM"
mkdir -p "$HOME"/.config/{nvim/{config,ftplugin,undo,.swapfiles,viminfo,addit-lang-servers},coc/extensions}

chmod +x ./softlink_config.sh && ./softlink-configs.sh

# To install plugins
nvim +PlugInstall
# To install coc extensions
nvim

# Kotlin language server
if hash gradle; then
	mkdir -p "$HOME/gitclones" && cd "$HOME/gitclones" || exit
	git clone https://github.com/fwcd/KotlinLanguageServer.git
	cd KotlinLanguageServer || exit
	./gradlew server:build
	cd "$HOME/.config/nvim/addit-lang-servers" || exit
	ln -s "$HOME/gitclones/KotlinLanguageServer/server/build/install/server/bin/server" \
		"./kotlin-language-server"
fi

function inst_if_exists() {
	prog="$1"; shift
	switch="$1"; shift
    if hash "$prog" 2>/dev/null; then
        echo "Installing {$*} with {$prog}..."
        "$prog" install "$switch" "$@"
    else
        echo "No {$prog} bin found..."
    fi
}


inst_if_exists "pip3" "--user" \
	"pynvim" "vim-vint"
inst_if_exists "npm"  "-g" \
	"neovim" "bash-language-server" "dockerfile-language-server-nodejs"
inst_if_exists "gem"  "" \
	"neovim"

nvim +UpdateRemotePlugins
nvim "+call coc#util#build()"
