#!/usr/bin/env sh

# Notifies upcoming events in the ~/bin/timetable/daily.x files, plus
# the more general ~/bin/timetable/calendar file. Note that all of these
# files must be present, so you may want to run the following commands
# to create them.
#
#       $ mkdir -p ~/bin/timetable
#       $ touch ~/bin/timetable/calendar ~/bin/timetable/daily.{1..7}
#
# Each of these files is written with lines in the following format:
#
#       event time,title,description,google meet code (or additional info)
#
# The description, google meet code are optional. Note that 'event time'
# must be in a valid 'date --date=' string format. For example, '14:30'
# (2:30 pm on the current day) or '16:45 January 11 2020' are valid.
# The daily.x files usually have 'event time' in the simple HH:MM format,
# while the calendar file mentions the full time and date.

# Run as a timed systemd service.

SECONDS_BEFORE=300

currentdate=$(date +%s)
tablefile="$HOME/bin/timetable/daily.$(date +%u)"
calendarfile="$HOME/bin/timetable/calendar"
cachefile="$HOME/bin/timetable/.cache"

touch "$cachefile"
cache="$(cat $cachefile)"

IFS=,
cat "$tablefile" "$calendarfile" | while read line; do

        [[ -z "$line" ]] && continue

        read etime title description meetcode <<< $line
        eventdate="$(date --date=$etime +%s)"

        echo $eventdate $title $description

        [[ ! -z $(echo "$cache" | grep "$eventdate$title") ]] && continue
        [[ $eventdate -lt $currentdate ]] && continue

        diff=$(($eventdate-$currentdate))
        [[ $diff -gt "$SECONDS_BEFORE" ]] && continue


        hhmm="$(date --date=$etime +%H:%M)"
        notify-send -u critical \
                "$title at $hhmm" "$description\n<span foreground='gray'>$meetcode</span>" \
                -h string:x-canonical-private-synchronous:"$hhmm $title" && \
        echo "$eventdate$title" >> $cachefile

done
