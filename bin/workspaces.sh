#!/usr/bin/env sh

workspaces=""
focused="$(bspc query -D -d focused --names)"
occupied="$(bspc query -D -d .occupied --names)"

for w in $(bspc query -D --names); do
        if [[ "$focused" == "$w" ]]; then
                workspaces="$workspaces <b><span foreground='#81a2be'>$w</span></b>"
        elif [[ "$occupied" =~ "$w" ]]; then
                workspaces="$workspaces $w"
        else
                workspaces="$workspaces <span foreground='#969896'>$w</span>"
        fi
done
echo $workspaces
