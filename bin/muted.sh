#!/usr/bin/env sh

muted=$(pamixer --get-volume-human)
if [[ "$muted" == "muted" ]]; then
        echo "muted"
else
        echo "unmuted"
fi
