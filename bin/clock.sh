#!/usr/bin/bash

Clock() {
        DATETIME=$(date "+%a %b %d, %T")

        echo -n "$DATETIME"
}

while true; do
        echo "%{c}$(Clock)"
        sleep 1
done
