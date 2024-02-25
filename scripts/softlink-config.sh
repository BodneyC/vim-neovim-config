#!/bin/bash

if [[ $1 == "-f" ]]; then
  rm -r ~/.config/{nvim,coc}
fi

mkdir -p ~/.config/nvim/undo
touch ~/.notags

cd "${BASH_SOURCE[0]}/../nvim" || {
  echo "No such dir (${BASH_SOURCE[0]}/../nvim)"
  exit 1
}
for f in *; do
  ln -s "$PWD/$f" ~/.config/nvim
done

cd / && sudo -E ln -s "$HOME" home-link
