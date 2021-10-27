#!/usr/bin/env sh

padding=$(bspc config -d focused top_padding)
gap=$(bspc config -d focused window_gap)

if [[ $1 == "padding" ]]; then
        padding=$(( ($padding + 64) % 256 ))
        for direction in top bottom left right ; do
                bspc config -d focused "${direction}_padding" $padding
        done
elif [[ $1 == "gap" ]]; then
        gap=$(( ($gap + 12) % 48 ))
        bspc config -d focused window_gap $gap
fi


