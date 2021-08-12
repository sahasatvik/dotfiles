#!/usr/bin/env sh

calendarfile="$HOME/.config/calendar"

strip_excess() {
        sed 's/^\s*#.*$//g' | sed '/^$/d' | sed 's/\s*,\s*/,/g'
}

format_entries() {
        IFS=,
        cat "$calendarfile" | strip_excess | while read line; do
                read etime title description meetcode <<< $line
                [[ -z "$meetcode" ]] && continue
                printf "  %-22s  <span color=\"#777777\">%-46s</span> %16s\n" "$title" "$description" "$meetcode"
        done
}

get_code() {
        format_entries \
                | sort -u \
                | rofi -dmenu -markup-rows -i -p 'gmeet' \
                | sed 's/^.* //g'
}

meetcode="$(get_code)"
if [[ ! -z "$meetcode" ]]; then
        chrome --profile-directory="Profile 1" --app="https://meet.google.com/$meetcode"
fi
