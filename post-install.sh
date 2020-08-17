#!/usr/bin/env bash

FZF_PREVIEW_SCRIPT="$HOME/.local/share/nvim/plugged/fzf.vim/bin/preview.sh"

[[ -f "$FZF_PREVIEW_SCRIPT" ]] && \
  sed -i 's/REVERSE=.*/REVERSE="\\x1b\[3m\\x1b\[1m/' "$FZF_PREVIEW_SCRIPT"
