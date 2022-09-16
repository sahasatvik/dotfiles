#!/usr/bin/env sh

status="$(cmus-remote -C status)"
[[ -z "$status" ]] && exit 1

playing=$(echo "$status" | grep ^status | sed 's/^status //g')

heading=""
case "$playing" in
        playing)
                heading="Playing" ;;
        paused)
                heading="Paused" ;;
        stopped)
                heading="Stopped" ;;
esac

file=$(echo "$status" | grep '^file' | sed 's/^file //g')
[[ -z "$file" ]] && exit 1

function body() {
        title=$(echo "$status" | grep '^tag title' | sed 's/^tag title //g')
        artist=$(echo "$status" | grep '^tag artist' | sed 's/^tag artist //g')
        composer=$(echo "$status" | grep '^tag composer' | sed 's/^tag composer //g')

        echo "<span color='#81a2be'>$artist</span>"
        [[ ! -z "$composer" ]] && echo "<span color='#aeafad'>$composer</span>"
        echo "<span color='#aeafad'>$title</span>"
}

notify-send -u low \
        -i $(~/bin/musicthumbnail.sh "$file") \
        -h string:x-canonical-private-synchronous:cmus \
        "$heading" \
        "$(body)"
