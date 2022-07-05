#!/usr/bin/env sh

muted=$(pamixer --get-volume-human)
if [[ "$muted" == "muted" ]]; then
        echo "#cc6666"
else
        echo "#84a2be"
fi
