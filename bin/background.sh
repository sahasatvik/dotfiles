#!/usr/bin/bash

# Sets a random wallpaper, replaces it with a solid
# background whenever there are open windows on the
# current desktop. This can be toggled to keep the 
# wallpaper when the windows are floating.

imagedir="$HOME/Pictures/wallpapers/random/"
image="$imagedir/$(ls $imagedir | shuf -n 1)"
color="#1d1f21"
mode=""

function count() {
        bspc query -N -n ".window$mode" -d focused | wc -l
}

function toggle() {
        if [ -z "$mode" ]; then
                mode=".tiled"
        else
                mode=""
        fi
        watchwindows
}

function watchwindows() {
        bspc subscribe | while read -a msg ; do
                if [ $(count) -ne 0 ]; then
                        hsetroot -solid "$color"
                else
                        hsetroot -solid "$color" -center "$image"
                fi
        done
}

trap toggle SIGUSR1
watchwindows
