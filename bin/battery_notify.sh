#!/usr/bin/env sh

[[ "$(acpi)" =~ "Charging" ]] && exit 0

battery="$(acpi | sed -E 's/.*[^0-9]([0-9]+)%.*/\1/g')"

if [[ "$battery" -le 15 ]]; then
        notify-send -u critical -h string:bgcolor:'#ff3334' "Critically low power! ($battery%)" \
                -h string:x-canonical-private-synchronous:power_crit
elif [[ "$battery" -le 30 ]]; then
        notify-send -u critical -h string:bgcolor:'#ffaa55' "Low power! ($battery%)" \
                -h string:x-canonical-private-synchronous:power_low
fi
