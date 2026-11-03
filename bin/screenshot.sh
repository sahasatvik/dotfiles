#!/usr/bin/env sh

imagedir="$HOME/Pictures/screenshots/"
timestamp="$(date +'%F %H-%M-%S')"
timenano="$(date +%N)"
image="$timestamp.png"
[[ -f "$imagedir$image" ]] && image="$timestamp $timenano.png"

filename="$imagedir$image"
touch "$filename"

fail() {
        rm "$filename"
        exit 1
}

case $1 in
        desktop)
                grim "$filename" || fail ;;
        selection)
                grim -g "$(slurp -d)" "$filename" || fail ;;
        window)
                window=$(mmsg get focusing-client | jq -r '"\(.x),\(.y) \(.width)x\(.height)"')
                grim -g "$window" "$filename" || fail ;;
        *)
                fail ;;
esac

notify-send -t 3000 -i "$filename" -u low "Screenshot" "$image"
