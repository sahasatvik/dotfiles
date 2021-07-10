#!/usr/bin/env sh

currenttime=$(date +%s)

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

seconds_before=300                              # notify this many seconds before the event
calendarfile="$HOME/.config/calendar"           # calendar event file
logfile="$HOME/.calendarlog"                    # logs notified events

touch "$logfile"
log="$(cat $logfile)"

IFS=,
cat "$calendarfile" | \
sed 's/^\s*#.*$//g' | sed '/^$/d' | \
while read line; do
        read etime title description meetcode <<< $line
        eventtime="$(date --date=$etime +%s)"

        [[ ! -z $(echo "$log" | grep "$eventtime $title") ]] && continue
        [[ $eventtime -lt $currenttime ]] && continue

        diff=$(($eventtime-$currenttime))
        [[ $diff -gt "$seconds_before" ]] && continue

        echo $eventtime $title $description
        hhmm="$(date --date=$etime +%H:%M)"
        notify-send -u critical \
                "$title at $hhmm" "$description\n<span foreground='gray'>$meetcode</span>" \
                -h string:x-canonical-private-synchronous:"$hhmm $title" && \
        echo "$eventtime $title" >> $logfile
done
