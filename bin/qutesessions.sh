#!/usr/bin/env sh

list_sessions() {
        fd --type file .yml $HOME/.local/share/qutebrowser/sessions \
                | sed 's#.*/##g' \
                | sed 's#.yml$##g' \
                | grep -vx "_autosave" \
                | sort
}

get_session() {
        list_sessions \
                | rofi -dmenu -markup-rows -i -p 'qutebrowser'
}

session="$(get_session)"

[[ -z "$session" ]] && exit

qutebrowser -r "$session" &
