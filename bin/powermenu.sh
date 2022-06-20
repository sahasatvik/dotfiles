#!/usr/bin/env sh

opt_lock=""
opt_sleep=""
opt_logout=""
opt_reboot="累"
opt_poweroff="襤"

get_option() {
        echo -e "$opt_poweroff\n$opt_reboot\n$opt_lock\n$opt_sleep\n$opt_logout" \
                | rofi -dmenu -config ~/.config/rofi/powermenu.rasi -selected-row 2 -u 0 -a 1 -p "$(uptime -p)"
}

option="$(get_option)"

[[ -z "$option" ]] && exit

case "$option" in
        $opt_lock)
                dm-tool lock
                ;;
        $opt_sleep)
                systemctl suspend
                ;;
        $opt_logout)
                bspc quit
                ;;
        $opt_reboot)
                systemctl reboot
                ;;
        $opt_poweroff)
                systemctl poweroff
                ;;
esac
