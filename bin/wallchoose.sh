#!/usr/bin/env sh

walldir="$HOME/Pictures/wallpapers/"
current="$(cat $HOME/Pictures/wallpapers/current)"

list_wallpapers() {
        echo $current
        fd --type file -e png -e jpg . "$walldir" \
                | LC_COLLATE=C sort \
                | grep -v ^"$current"$
}

get_wallpaper() {
        list_wallpapers \
                | xargs -i echo -en "{}\x00icon\x1f{}\x00\n" \
                | rofi  -dmenu \
                        -config ~/.config/rofi/wallpapers.rasi \
                        -show-icons
}

wallpaper="$(get_wallpaper)"

[[ -z "$wallpaper" ]] && exit
~/bin/wallset.sh "$wallpaper"
