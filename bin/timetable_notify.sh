#!/usr/bin/env sh

# Reads events from the ~/bin/timetable/day.x files and notifies 5 minutes in advance.
# Ideally run as a systemd user service.

IFS=,
while true; do
        
        tablefile="$HOME/bin/timetable/day.$(date +%u)"                 # Set the timetable file
        currentdate=$(date +%s)                                         # Get the current UNIX timestamp
        cache=$(cat $HOME/bin/timetable/.cache)                         # Load the cache of already notified events
        
        while read line; do
                [[ -z "$line" ]] && continue                            # Skip empty lines

                read hhmm title description meetcode <<< $line          # Read the line into vars        
                eventdate=$(date --date=$hhmm +%s)                      # Get the event UNIX timestamp

                [[ ! -z $(echo "$cache" | grep "$eventdate$title") ]] && continue
                                                                        # Skip if found in cache
                [[ $eventdate -lt $currentdate ]] && continue           # Skip if overdue

                diff=$(($eventdate-$currentdate))                       # Calculate the seconds remaining
                [[ $diff -gt "300" ]] && continue                       # Skip if over 5mins remaining

                notify-send -u critical \
                        "$title at $hhmm" "$description\n<span foreground='gray'>$meetcode</span>" \
                        -h string:x-canonical-private-synchronous:"$hhmm $title"

                echo "$eventdate$title" >> $HOME/bin/timetable/.cache   # Add to cache

        done < $tablefile
        sleep 60
done
