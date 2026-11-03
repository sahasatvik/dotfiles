#!/usr/bin/env sh

player="$1"

artdir="$HOME/.cache/albumart"

function get_album_art() {
        artpath=""
        case "$1" in
                /*)
                        filename="$(echo "$art" | sha256sum | cut -d' ' -f1)"
                        artpath="$artdir/$filename.png"
                        [[ -f "$artpath" ]] || ffmpeg -i "$art" -an -c:v copy "$artpath"
                        ;;
                file://*)
                        artpath="${1/file:\/\//}"
                        ;;
                http://* | https://*)
                        filename="$(basename $1)"
                        artpath="$artdir/$filename"
                        [[ -f "$artpath" ]] || wget -O "$artpath" "$1"
                        ;;
        esac
}

function notify() {
        status="$(playerctl --player=$player metadata --format '{{status}}')"
        title="$(playerctl --player=$player metadata title)"
        album="$(playerctl --player=$player metadata album)"
        artist="$(playerctl --player=$player metadata artist)"

        case $player in
                spotify)
                        art="$(playerctl --player=$player metadata mpris:artUrl)"
                        ;;
                cmus)
                        cmusstatus="$(cmus-remote -C status)"
                        art=$(echo "$cmusstatus" | grep ^file | cut -b6-)
                        composer=$(echo "$cmusstatus" | grep '^tag composer' | cut -b14-)
                        [[ -z "$composer" ]] || title="$title\n[$composer]"
                        ;;
        esac
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
