#!/usr/bin/bash

function count() {
        bspc query -N -n ".window.descendant_of" | wc -l
}

bspc subscribe | while read -a msg ; do
        bspc config border_width 0
        if [ $(count) -gt 1 ]; then
                bspc config -n focused border_width 2
        fi
done
