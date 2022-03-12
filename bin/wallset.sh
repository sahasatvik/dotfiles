#!/usr/bin/env sh

[[ -z "$1" ]] && exit 1;

WALL_DIR="$HOME/Pictures/wallpapers/main"
WALL_BLUR_DIR="$HOME/Pictures/wallpapers/blur"
WALL_CURRENT="$HOME/Pictures/wallpapers/current"

hsetroot -cover "$1" &> /dev/null
wall_basename=$(basename -- "$1")
wall_blur="$WALL_BLUR_DIR/$wall_basename"

if [[ ! -f "$wall_blur" ]]; then
        convert "$1" -brightness-contrast -6x0 -blur 0x4 "$wall_blur"
fi
cp "$wall_blur" /etc/lightdm/background.jpg

