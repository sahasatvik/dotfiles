#!/usr/bin/bash

Clock() {
        DATE=$(date "+%a %b %d")
        TIME=$(date "+%T")

        echo -n "%{F#bbbbbb}$DATE%{F-}, $TIME"
}

while true; do
        echo "%{c}$(Clock)"
        sleep 1
done
