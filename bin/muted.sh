#!/usr/bin/env sh

muted=$(amixer sget Master | grep 'Mono:' | sed -E 's/.*\[(on|off)\].*/\1/g')
if [[ "$muted" == "off" ]]; then
        echo "muted"
else
        echo "unmuted"
fi
