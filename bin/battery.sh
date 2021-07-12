#!/usr/bin/env sh

percent=$(acpi | sed -E 's/.*[^0-9]([0-9]+)%.*/\1/g')
if [[ $percent -gt 50 ]]; then
        echo $percent
elif [[ $percent -gt 25 ]]; then
        echo "<b><span foreground='#cd9a76'>$percent%</span></b>"
elif [[ $percent -gt 15 ]]; then
        echo "<b><span foreground='#ffaa55'>$percent%</span></b>"
else
        echo "<b><span foreground='#ff3334'>$percent%</span></b>"
fi

