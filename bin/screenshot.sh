#!/usr/bin/env sh

imagedir="$HOME/Pictures/screenshots/"
timestamp="$(date +%s)"
timenano="$(date +%N)"
image="screenshot-$timestamp.png"
[[ -f "$imagedir$image" ]] && image="screenshot-$timestamp-$timenano.png"

filename="$imagedir$image"
touch "$filename"

fail() {
        rm "$filename"
        exit 1
}

case $1 in
        desktop)
                maim -u "$filename" || fail ;;
        selection)
                maim -us "$filename" || fail ;;
        window)
                maim -ui "$(xdotool getactivewindow)" "$filename" || fail ;;
        *)
                fail ;;
esac

notify-send -t 3000 -i "$filename" -u low "Screenshot" "$image"
