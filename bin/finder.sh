#!/usr/bin/env sh

get_filepath() {
        fd --base-directory="$HOME" \
                | sort \
                | rofi -dmenu -i -p 'find'
}

filepath="$(get_filepath)"
filedir=$(dirname "$HOME/$filepath")

[[ -z "$filepath" ]] && exit

if [[ "$filepath" == ./Videos/* ]]; then
        mpv "$filepath"
else
        cd "$filedir"
        xdg-open "$HOME/$filepath" &
fi
