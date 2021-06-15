#!/usr/bin/env sh

status="$(cmus-remote -C status | grep status | sed 's/status //g')"

if [[ "$status" == "playing" ]]; then
        title="$(cmus-remote -C status | grep 'tag title' | sed 's/tag title //g')"
        artist="$(cmus-remote -C status | grep 'tag artist' | sed 's/tag artist //g')"

        echo "<b>Playing</b>    :"
        echo "    $title"
        echo "    <span foreground='#969896'>$artist</span>"
elif [[ "$status" == "paused" ]]; then
        title="$(cmus-remote -C status | grep 'tag title' | sed 's/tag title //g')"
        artist="$(cmus-remote -C status | grep 'tag artist' | sed 's/tag artist //g')"
        
        echo "<b>Paused</b>     :"
        echo "    $title"
        echo "    <span foreground='#969896'>$artist</span>"
fi
