#!/usr/bin/env sh

highlight="#87a1bb"

month() {
        m=${1:-this}
        cal --monday $(date --date="$m month" +"%m %Y")\
                | sed "/^\\s*$/d"
}

highlight_today() {
        d=$(date +%e)
        sed "s/^$d[^0-9]/<span weight='bold' color='$highlight'>$d<\/span> /g" \
                | sed "s/ $d / <span weight='bold' color='$highlight'>$d<\/span> /g" \
                | sed "s/ $d$/ <span weight='bold' color='$highlight'>$d<\/span>/g"
}

calendar() {
        if [[ "$1" == "long" ]]; then
                month last
                echo
        fi
        month | highlight_today
        if [[ "$1" == "long" ]]; then
                echo
                month next
        fi
}

rofi -e "$(calendar $1)" \
        -config ~/.config/rofi/calendar.rasi \
        -markup
