#!/usr/bin/env sh

WALL_CURRENT="$HOME/Pictures/wallpapers/current"

imgpath=${1:-$(cat $WALL_CURRENT)}
[[ ! -f "$imgpath" ]] && exit 1;

echo $imgpath

# Set the current wallpaper and update the 'current' file

killall swaybg &> /dev/null
swaybg -i "$imgpath" -m fill &> /dev/null &
echo "$imgpath" > "$WALL_CURRENT"
