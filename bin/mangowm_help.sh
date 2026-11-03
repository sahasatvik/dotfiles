#!/usr/bin/env sh

conf="$HOME/.config/mango/config.conf"

grep '#?' "$conf" \
        | sed -E 's@#?bind[lsrpc]?=([^,]*),([^,]*),.*#\?(.*)@\1+\2#<small>\3</small>@g' \
        | sed 's/+/ + /g' \
        | column -td -s '#' -C "width=48" \
        | rofi -dmenu -markup-rows -i -p "keys"
