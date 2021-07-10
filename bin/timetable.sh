#!/usr/bin/env sh

# Events are placed in ~/bin/timetable/daily.x files, where 'x' varies
# from 1-7 denoting Monday-Sunday.
# Each of these files is written with lines in the following format:
#
#       event time,title,description,google meet code
#
# The description, google meet code are optional.
# The 'event time' is in simple HH:MM format.

tablefile="$HOME/bin/timetable/daily.$(date +%u)"

cat $tablefile | awk -F',' '{printf "<span color=\"#777777\">%6s</span>%8s  <span color=\"#777777\">%-50s</span> %16s\n", $1, $2, $3, $4}'
