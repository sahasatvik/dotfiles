#!/usr/bin/bash

# Displays border on focused windows, if more than one.

function count() {
        bspc query -N -n ".window.descendant_of" | wc -l
}

bspc subscribe | while read -a msg ; do
        bspc config focused_border_color "#2a2f35"
        if [ $(count) -gt 1 ]; then
                bspc config -n focused focused_border_color "#81a2be"
        fi
done
