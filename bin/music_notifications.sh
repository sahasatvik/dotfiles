#!/usr/bin/env sh

player="$1"

artdir="$HOME/.cache/albumart"

function get_album_art() {
        artpath=""
        if [[ $1 == "file://"* ]]; then
                artpath="${1/file:\/\//}"
        elif [[ $1 == "http://"* ]] || [[ $1 == "https://"* ]] ; then
                filename="$(basename $1)"
                artpath="$artdir/$filename"
                [[ -f "$artpath" ]] || wget -O "$artpath" "$1"
        fi
}

function notify() {
        title="$(playerctl --player=$player metadata title)"
        album="$(playerctl --player=$player metadata album)"
        artist="$(playerctl --player=$player metadata artist)"
        art="$(playerctl --player=$player metadata mpris:artUrl)"
        status="$(playerctl --player=$player metadata --format '{{status}}')"
        get_album_art "$art" &> /dev/null
        notify-send \
                -u low \
                -a "$player" \
                -h string:x-canonical-private-synchronous:"$player" \
                -i "$artpath" \
                "$status" \
                "$title\n<i>$artist</i>\n"
}

playerctl --player=$player metadata --follow --format "{{status}} - {{title}} - {{artist}} - {{album}}" \
        | while read -r update; do
        [[ -z "$update" ]] || notify
done
