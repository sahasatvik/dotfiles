#!/usr/bin/env sh

imagedir="$HOME/Pictures/screenshots/"
timestamp="$(date +%s)"
timenano="$(date +%N)"
image="screenshot-$timestamp.png"
[[ -f "$imagedir$image" ]] && image="screenshot-$timestamp-$timenano.png"

filename="$imagedir$image"
touch "$filename"

case $1 in
        desktop)
                maim -u "$filename" ;;
        selection)
                maim -us "$filename" ;;
        window)
                maim -ui "$(xdotool getactivewindow)" "$filename" ;;
        *)
                rm "$filename"
                exit 1 ;;
esac

notify-send -t 3000 -i "$filename" -u low "Screenshot" "$image"
