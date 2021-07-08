#!/usr/bin/env sh

# The ~/bin/meets file contains rows of the following form (the last entry is the meet code)
# title,description,abc-def-ghi

cat ~/bin/meets | sed 's/,\(.*\),/,<span color="#777777">\1<\/span>,/g' | awk -F',' '{printf "%-26s%-70s%16s\n", $1, $2, $3}'
