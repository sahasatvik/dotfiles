#!/usr/bin/env sh

muted="$($HOME/bin/muted.sh)"
wifi="$($HOME/bin/wificonnected.sh)"
blue="$($HOME/bin/bluetoothconnected.sh)"

mutetext=""
if [[ "$muted" == "muted" ]]; then
        mutetext="(<span foreground='#cc6666'>muted</span>)"
fi

echo "<b>Volume</b>     : $($HOME/bin/volume.sh) $mutetext"
echo "<b>Brightness</b> : $($HOME/bin/brightness.sh)"
echo "<b>Battery</b>    : $($HOME/bin/battery.sh)"


if [[ ! -z "$wifi" ]]; then
        echo "<b>Network</b>    : $wifi"
fi
if [[ ! -z "$blue" ]]; then
        echo "<b>Bluetooth</b>  : $blue"
fi

echo "<b>Workspaces</b> : $($HOME/bin/workspaces.sh)"
