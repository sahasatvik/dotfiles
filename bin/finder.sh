#!/usr/bin/env sh

get_filepath() {
        fd --base-directory="$HOME" \
                | sort \
                | rofi -dmenu -i -p 'find'
}

filepath="$(get_filepath)"
filedir=$(dirname "$HOME/$filepath")
if [[ ! -z "$filepath" ]]; then
        cd "$filedir"
        xdg-open "$HOME/$filepath" &
fi
