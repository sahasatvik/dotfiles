#!/usr/bin/env sh

# The ~/bin/meets file contains rows of the following form (the last entry is the meet code)
# title,description,abc-defg-hij

cat $HOME/bin/meets | awk -F',' '{printf "%-26s<span color=\"#777777\">%-40s</span> %16s\n", $1, $2, $3}'
