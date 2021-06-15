#!/usr/bin/env sh

percent=$(acpi | sed -E 's/.*[^0-9]([0-9]+)%.*/\1/g')
if [[ $percent -gt 50 ]]; then
        echo "$percent%"
elif [[ $percent -gt 30 ]]; then
        echo "<b><span foreground='#de935f'>$percent%</span></b>"
else
        echo "<b><span foreground='#cc6666'>$percent%</span></b>"
fi

