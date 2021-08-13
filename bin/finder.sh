#!/usr/bin/env sh

get_filepath() {
        fd --base-directory="$HOME" \
                | sort \
                | rofi -dmenu -i -p 'find'
}

filepath="$HOME/$(get_filepath)"
filedir=$(dirname "$filepath")
if [[ ! -z "$filepath" ]]; then
        cd "$filedir"
        xdg-open "$filepath"
fi
