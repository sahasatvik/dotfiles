#!/usr/bin/env sh

THUMBS="/tmp/musicthumbnails/"

file="$1"
[[ ! -f "$file" ]] && exit 1

[[ -d "$THUMBS" ]] || mkdir "$THUMBS"

thumbname=$(echo "$file" | sha256sum | cut -d' ' -f1)
thumbfile="${THUMBS}${thumbname}.png"

[[ -f "$thumbfile" ]] || ffmpeg -i "$file" -an -c:v copy "$thumbfile" &> /dev/null

echo "$thumbfile"
