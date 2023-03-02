#!/usr/bin/env sh

uuids() {
        bluetoothctl devices | cut -f2 -d' '
}

is_connected() {
        bluetoothctl info "$1" | grep -e "Connected: yes"
}

uuid_to_device() {
        bluetoothctl devices \
                | grep -e "$1" \
                | sed "s/.*$1\s*\(.*\)$/\1/g"
}

uuids | while read uuid; do
        if [[ "$(is_connected $uuid)" ]]; then
                uuid_to_device "$uuid"
        fi
done
