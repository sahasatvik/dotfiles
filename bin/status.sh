#!/usr/bin/env sh

muted="$(/home/satvik/bin/muted.sh)"
mutetext=""
if [[ "$muted" == "muted" ]]; then
        mutetext="(<span foreground='#cc6666'>muted</span>)"
fi

echo "<b>Volume</b>     : $(/home/satvik/bin/volume.sh) $mutetext"
echo "<b>Brightness</b> : $(/home/satvik/bin/brightness.sh)"
echo "<b>Battery</b>    : $(/home/satvik/bin/battery.sh)"
echo "<b>Workspaces</b> : $(/home/satvik/bin/workspaces.sh)"
echo "$(/home/satvik/bin/cmusinfo.sh)"
