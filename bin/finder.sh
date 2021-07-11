#!/usr/bin/env sh

get_filepath() {
        fd --base-directory="$HOME" \
                | sort \
                | rofi -dmenu -i -p 'find'
}

filepath="$(get_filepath)"
if [[ ! -z "$filepath" ]]; then
        xdg-open "$HOME/$filepath"
fi
