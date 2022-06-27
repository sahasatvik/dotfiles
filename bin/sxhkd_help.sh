#!/usr/bin/env sh

awk '/^[a-zA-Z{]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc | column -t -s $'\t' | rofi -dmenu -i -p "keys"
