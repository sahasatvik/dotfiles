#!/usr/bin/env sh

walldir="$HOME/Pictures/wallpapers/main/"

get_wallpaper() {
        fd --type file . "$walldir" \
                | sort \
                | xargs -i echo -en "{}\x00icon\x1f{}\n" \
                | rofi  -dmenu \
                        -config ~/.config/rofi/wallpapers.rasi \
                        -show-icons
}

wallpaper="$(get_wallpaper)"

[[ -z "$wallpaper" ]] && exit
~/bin/wallset.sh "$wallpaper"
