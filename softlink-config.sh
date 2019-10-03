#!/bin/bash

mkdir -p ~/.config/{nvim,coc}

_msg_exit() { # msg[, ret_val]
	echo "$1, exiting..."
	[[ -n "$2" ]] && exit "$2"
}

_yes_or_no() { # msg
	# shellcheck disable=SC2050
	while [[ 1 == 1 ]]; do
		read -rp "$1 [yn] "
		case "$REPLY" in
			[yY]*) return 0 ;;
			[nN]*) return 1 ;;
			*)     echo "Invalid option"
		esac
	done
}

_process() {
	realpath="$1"; basename="$2"; home_file="$3"
	echo
	cd "$(dirname "$home_file")" || { _msg_exit "Could not CD to $home_file dir"; return 1; }
	if [[ -e "$basename" ]]; then
		_yes_or_no "$home_file exists, delete?" || return 1
		/bin/rm -rf "$basename" || { _msg_ext "Could not delete $basename"; cd -; return 1; }
	fi
	ln -s "$realpath" "$(realpath "$basename")"
	cd - >& /dev/null || _msg_exit "Could not return to git repo" 1
}

if [[ "$1" == "-f" ]]; then
	rm -r ~/.config/{nvim,coc}
fi

mkdir -p ~/.config/{nvim,coc}

for f in nvim/{init.vim,coc-settings.json,ftplugin,config,addit-lang-servers} coc/{ultisnips,extensions/{package.json,yarn.lock}}; do
	_process "$(realpath "$f")" "$(basename "$f")" "$HOME/.config/$f"
done
