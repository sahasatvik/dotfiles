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

battery_percentage() {
        bluetoothctl info "$1" \
                | grep -e "Battery Percentage: .*(.*)" \
                | sed "s/.*(\(.*\))/\1/g"
}

uuids | while read uuid; do
        if [[ "$(is_connected $uuid)" ]]; then
                device="$(uuid_to_device $uuid)"
                if [[ "$(battery_percentage $uuid)" ]]; then
                        battery=" ($(battery_percentage $uuid)%)"
                fi
                echo "$device$battery"
        fi
done
