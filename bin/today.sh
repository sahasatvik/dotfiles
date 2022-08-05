#!/usr/bin/env sh

currenttime="$(date +%s)"
todaydate="$(date +%D)"

# Events are placed in $calendarfile.
# The lines of this file are written in the following format.
#
#       event time, title, description, google meet code (or additional info)
#
# The description, google meet code are optional. Note that 'event time'
# must be in a valid 'date --date=' string format. For example, '14:30'
# (2:30 pm on the current day), '12:15 Wed' (12:15 pm every Wednesday - 
# useful for daily timetables), or '16:45 January 11 2020' are valid.
# The file may contain comments (#) and empty lines.

calendarfile="$HOME/.config/calendar"           # calendar event file

strip_excess() {
        sed 's/^\s*#.*$//g' | sed '/^$/d' | sed 's/\s*,\s*/,/g'
}

format_entries() {
        IFS=,
        cat "$calendarfile" | strip_excess | while read line; do
                read etime title description meetcode <<< $line
                eventdate="$(date --date=$etime +%D)"

                [[ "$eventdate" != "$todaydate" ]] && continue

                eventtime="$(date --date=$etime +%s)"
                hhmm="$(date --date=$etime +%H:%M)"

                if [[ $eventtime -lt $currenttime ]]; then
                        printf "<span color=\"#444444\">%5s  %-17s  %-46s %16s</span>\n" "$hhmm" "$title" "$description" "$meetcode"
                else
                        printf "%5s  %-17s  <span color=\"#777777\">%-46s</span> %16s\n" "$hhmm" "$title" "$description" "$meetcode"
                fi
        done
}

get_code() {
        format_entries \
                | sort \
                | rofi -dmenu -markup-rows -i -p 'today' \
                | sed 's/<[^>]*>//g' \
                | sed 's/^.* //g'
}

meetcode="$(get_code)"
if [[ ! -z "$meetcode" ]]; then
        chrome --profile-directory="Profile 1" --app="https://meet.google.com/$meetcode"
fi
