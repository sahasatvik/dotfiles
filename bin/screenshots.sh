#!/usr/bin/env sh

imagedir="$HOME/Pictures/screenshots/"

get_image() {
        find "$imagedir" -type f -printf "%T+ %p\n" \
                | sort -r \
                | cut -d " " -f 2- \
                | sed -e "s#^$imagedir##" \
                | xargs -i echo -en "{}\x00icon\x1f$imagedir/{}\n" \
                | rofi  -dmenu \
                        -p "screenshots" \
                        -config ~/.config/rofi/gallery.rasi \
                        -show-icons
}

image="$(get_image)"

[[ -z "$image" ]] && exit
xdg-open "$imagedir/$image" &
