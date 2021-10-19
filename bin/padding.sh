#!/usr/bin/env sh

current=$(bspc config -d focused top_padding)
if [[ $current == "0" ]]; then
        padding=8
        gap=32
else
        padding=0
        gap=6
fi

for direction in top bottom left right ; do
        bspc config -d focused "${direction}_padding" $padding
done
bspc config -d focused window_gap $gap

