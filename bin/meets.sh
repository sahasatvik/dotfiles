#!/usr/bin/env sh

meetfile="$HOME/.config/meets"

format_entries() {
        cat $meetfile \
                | sed 's/^\s*#.*$//g' \
                | sed '/^$/d' \
                | sed 's/\s*,\s*/,/g' \
                | awk -F',' '{printf "%-26s<span color=\"#777777\">%-46s</span> %16s\n", $1, $2, $3}'
}

get_code() {
        format_entries \
                | rofi -dmenu -markup-rows -i -p 'gmeet' \
                | sed 's/^.* //g'
}

meetcode="$(get_code)"
if [[ ! -z "$meetcode" ]]; then
        chrome --profile-directory="Profile 1" "https://meet.google.com/$meetcode"
fi
