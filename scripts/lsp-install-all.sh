#!/usr/bin/env bash

npm i -g {vim,yaml,docker,bash,typescript}-language-server \
  vscode-html-languageserver-bin vscode-json-languageserver \
  diagnostic-languageserver markdownlint
pip3 install 'python-language-sever[all]'
go get golang.org/x/tools/gopls@latest
rustup component add rls rust-{analysis,src}

# Sumneko Lua
cd "$HOME/software" || exit
! test -d lua-language-server && git clone --recurse-submodules https://github.com/sumneko/lua-language-server
cd lua-language-server || exit
git pull
cd 3rd/luamake && ninja -f ninja/linux.ninja
cd ../../ && ./3rd/luamake/luamake rebuild
