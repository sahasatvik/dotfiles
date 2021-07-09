#!/usr/bin/env sh

# The ~/bin/timetable/ diretory contains the files day.1 through day.7, which store
# the event data for the weekdays Monday through Sunday.
# The rows are of the following form (the last entry is the meet code)
# time,title,description,abc-defg-hij

tablefile="$HOME/bin/timetable/day.$(date +%u)"

cat $tablefile | awk -F',' '{printf "<span color=\"#777777\">%6s</span>%8s  <span color=\"#777777\">%-50s</span> %16s\n", $1, $2, $3, $4}'
