#!/usr/bin/env sh

muted="$($HOME/bin/muted.sh)"
mutetext=""
if [[ "$muted" == "muted" ]]; then
        mutetext="(<span foreground='#cc6666'>muted</span>)"
fi

echo "<b>Volume</b>     : $($HOME/bin/volume.sh) $mutetext"
echo "<b>Brightness</b> : $($HOME/bin/brightness.sh)"
echo "<b>Battery</b>    : $($HOME/bin/battery.sh)"
echo "<b>Workspaces</b> : $($HOME/bin/workspaces.sh)"
