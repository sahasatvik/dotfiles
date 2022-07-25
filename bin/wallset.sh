#!/usr/bin/env sh

[[ -z "$1" ]] && exit 1;
[[ ! -f "$1" ]] && exit 1;

WALL_DIR="$HOME/Pictures/wallpapers/main"
WALL_BLUR_DIR="$HOME/Pictures/wallpapers/blur"
WALL_CURRENT="$HOME/Pictures/wallpapers/current"

# Set the current wallpaper and update the 'current' file

hsetroot -cover "$1" &> /dev/null
echo "$1" > "$WALL_CURRENT"

# Generate a blurred version of the wallpaper for the lockscreen. If the
# filename starts with an underscore, run the 'background.sh' script, which
# replaces the wallpaper with a solid background when there are visible windows
# on the current desktop. Also use a solid background for the lockscreen.

wall_basename=$(basename -- "$1")
wall_blur="$WALL_BLUR_DIR/$wall_basename"

killall background.sh
if [[ "$wall_basename" == _* ]]; then
        $HOME/bin/background.sh &
        wall_blur="$HOME/Pictures/wallpapers/solid.jpg"
fi

if [[ ! -f "$wall_blur" ]]; then
        convert "$1" -brightness-contrast -6x0 -blur 0x4 "$wall_blur"
fi
cp "$wall_blur" /etc/lightdm/background.jpg


