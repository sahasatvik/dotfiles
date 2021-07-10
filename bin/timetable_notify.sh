#!/usr/bin/env sh

# Notifies upcoming events in the ~/bin/timetable/day.x files.
# Run as a timed systemd service.

SECONDS_BEFORE=300

currentdate=$(date +%s)
tablefile="$HOME/bin/timetable/day.$(date +%u)"

touch "$HOME/bin/timetable/.cache"
cache="$(cat $HOME/bin/timetable/.cache)"

IFS=,
while read line; do

        [[ -z "$line" ]] && continue

        read hhmm title description meetcode <<< $line
        eventdate=$(date --date=$hhmm +%s)

        [[ ! -z $(echo "$cache" | grep "$eventdate$title") ]] && continue
        [[ $eventdate -lt $currentdate ]] && continue

        diff=$(($eventdate-$currentdate))
        [[ $diff -gt "$SECONDS_BEFORE" ]] && continue

        notify-send -u critical \
                "$title at $hhmm" "$description\n<span foreground='gray'>$meetcode</span>" \
                -h string:x-canonical-private-synchronous:"$hhmm $title" && \
        echo "$eventdate$title" >> $HOME/bin/timetable/.cache

done < $tablefile
