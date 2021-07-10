#!/usr/bin/env sh

# Notifies upcoming events in the $calendarfile file.
# The lines of this file are written in the following format.
#
#       event time,title,description,google meet code (or additional info)
#
# The description, google meet code are optional. Note that 'event time'
# must be in a valid 'date --date=' string format. For example, '14:30'
# (2:30 pm on the current day), '12:15 Wed' (12:15 pm every Wednesday - 
# useful for daily timetables), or '16:45 January 11 2020' are valid.
# The file may contain comments (#) and empty lines.

# Run as a timed systemd --user service.

SECONDS_BEFORE=300
currentdate=$(date +%s)

calendarfile="$HOME/bin/calendar"
cachefile="$HOME/bin/.calendarcache"

touch "$cachefile"
cache="$(cat $cachefile)"

IFS=,
cat "$calendarfile" | \
sed 's/^\s*#.*$//g' | sed '/^$/d' | \
while read line; do

        read etime title description meetcode <<< $line
        eventdate="$(date --date=$etime +%s)"

        [[ ! -z $(echo "$cache" | grep "$eventdate $title") ]] && continue
        [[ $eventdate -lt $currentdate ]] && continue

        diff=$(($eventdate-$currentdate))
        [[ $diff -gt "$SECONDS_BEFORE" ]] && continue

        echo $eventdate $title $description
        hhmm="$(date --date=$etime +%H:%M)"
        notify-send -u critical \
                "$title at $hhmm" "$description\n<span foreground='gray'>$meetcode</span>" \
                -h string:x-canonical-private-synchronous:"$hhmm $title" && \
        echo "$eventdate $title" >> $cachefile

done
