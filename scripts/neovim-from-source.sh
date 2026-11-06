#!/usr/bin/env bash
set -euo pipefail

usage() {
	echo "Usage: ${0##*/} [-h|--help] [ref]"
	echo "  Build and install Neovim from source"
	echo "  ref  branch or tag to build (default: release-0.12, e.g. master, nightly, stable, v0.12.0)"
	echo
	echo "  NEOVIM_SRC     source checkout (default: ~/gitclones/neovim)"
	echo "  NEOVIM_PREFIX  install prefix (default: ~/.local)"
}

ref=release-0.12
while (($#)); do
	case $1 in
	-h | --help) usage && exit 0 ;;
	-*)
		echo "Unknown option: $1" >&2
		usage >&2
		exit 1
		;;
	*) ref=$1 ;;
	esac
	shift
done

src_dir=${NEOVIM_SRC:-$HOME/gitclones/neovim}
prefix=${NEOVIM_PREFIX:-$HOME/.local}

if [[ ! -d $src_dir/.git ]]; then
	mkdir -p "$(dirname "$src_dir")"
	git clone https://github.com/neovim/neovim.git "$src_dir"
fi
cd "$src_dir"

git fetch --all --tags --force --prune
if git rev-parse --verify --quiet "origin/$ref" >/dev/null; then
	git checkout --detach "origin/$ref"
else
	git checkout --detach "$ref"
fi

unset LUA_PATH LUA_CPATH
make clean
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX="$prefix"

if [[ -x $prefix/bin/nvim ]]; then
	cp "$prefix/bin/nvim" "$prefix/bin/nvim.bak"
fi
make install

"$prefix/bin/nvim" --version | head -n 1
