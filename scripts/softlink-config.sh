#!/usr/bin/env bash
set -euo pipefail

usage() {
	echo "Usage: ${0##*/} [-f|--force] [-h|--help]"
	echo "  Symlink this repo's nvim directory to \${XDG_CONFIG_HOME:-~/.config}/nvim"
	echo "  -f, --force  move an existing config aside instead of aborting"
}

force=false
while (($#)); do
	case $1 in
	-f | --force) force=true ;;
	-h | --help) usage && exit 0 ;;
	*)
		echo "Unknown argument: $1" >&2
		usage >&2
		exit 1
		;;
	esac
	shift
done

source_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/../nvim" && pwd)
config_dir=${XDG_CONFIG_HOME:-$HOME/.config}/nvim

mkdir -p "$source_dir/undo"

if [[ -L $config_dir && $(readlink "$config_dir") == "$source_dir" ]]; then
	echo "Already linked: $config_dir -> $source_dir"
	exit 0
fi

if [[ -e $config_dir || -L $config_dir ]]; then
	if ! $force; then
		echo "$config_dir already exists, rerun with -f to move it aside" >&2
		exit 1
	fi
	backup=$config_dir.bak.$(date +%Y%m%d%H%M%S)
	mv "$config_dir" "$backup"
	echo "Moved existing config to $backup"
fi

mkdir -p "$(dirname "$config_dir")"
ln -s "$source_dir" "$config_dir"
echo "Linked $config_dir -> $source_dir"
