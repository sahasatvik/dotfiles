#!/usr/bin/env sh

walldir="$HOME/Pictures/wallpapers/main/"
current="$(cat $HOME/Pictures/wallpapers/current)"

list_wallpapers() {
        fd --type file . "$walldir" \
                | LC_COLLATE=C sort
}

current_index() {
        list_wallpapers \
                | nl -v0 \
                | grep "$current"$ \
                | cut -f 1
}

get_wallpaper() {
        idx="$(current_index)"
        list_wallpapers \
                | xargs -i echo -en "{}\x00icon\x1f{}\x00\n" \
                | rofi  -dmenu \
                        -config ~/.config/rofi/wallpapers.rasi \
                        -show-icons \
                        -a "$idx" \
                        -selected-row "$idx"
}

wallpaper="$(get_wallpaper)"

[[ -z "$wallpaper" ]] && exit
~/bin/wallset.sh "$wallpaper"
