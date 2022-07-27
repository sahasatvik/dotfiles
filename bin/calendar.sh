#!/usr/bin/env sh

highlight="#ffffff"

calendar() {
        d=$(date +%e)
        cal --monday \
                | sed "/^\\s*$/d" \
                | sed "s/$d[^0-9]/<span color='$highlight'>$d<\/span> /g" \
                | sed "s/$d$/<span color='$highlight'>$d<\/span>/g"
}

rofi -e "$(calendar)" \
        -config ~/.config/rofi/calendar.rasi \
        -markup
