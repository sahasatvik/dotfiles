#!/usr/bin/env sh

cat $HOME/.config/meets | awk -F',' '{printf "%-26s<span color=\"#777777\">%-46s</span> %16s\n", $1, $2, $3}'
