#!/usr/bin/env sh

# Events are placed in $calendarfile.
# The lines of this file are written in the following format.
#
#       event time,title,description,google meet code
#
# The description, google meet code are optional. Note that 'event time'
# must be in a valid 'date --date=' string format. For example, '14:30'
# (2:30 pm on the current day), '12:15 Wed' (12:15 pm every Wednesday - 
# useful for daily timetables), or '16:45 January 11 2020' are valid.
# The file may contain comments (#) and empty lines.

calendarfile="$HOME/bin/calendar"

todaydate="$(date +%D)"
currenttime="$(date +%s)"

IFS=,
cat "$calendarfile" | \
sed 's/^\s*#.*$//g' | sed '/^$/d' | \
while read line; do
        
        read etime title description meetcode <<< $line
        eventdate="$(date --date=$etime +%D)"

        [[ "$eventdate" != "$todaydate" ]] && continue
        
        eventtime="$(date --date=$etime +%s)"
        hhmm="$(date --date=$etime +%H:%M)"

        if [[ $eventtime -lt $currenttime ]]; then
                echo "$hhmm,$title,$description,$meetcode" | \
                awk -F',' '{printf "<span color=\"#444444\">%6s  %-16s  %-46s %16s</span>\n", $1, $2, $3, $4}'
        else
                echo "$hhmm,$title,$description,$meetcode" | \
                awk -F',' '{printf "%6s  %-16s  <span color=\"#777777\">%-46s</span> %16s\n", $1, $2, $3, $4}'
        fi
done
