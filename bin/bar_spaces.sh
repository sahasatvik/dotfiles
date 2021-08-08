#!/usr/bin/bash

Workspaces() {
        FOCUSED="$(bspc query -D -d focused --names)"
        OCCUPIED="$(bspc query -D -d .occupied --names)"
        
        for w in $(bspc query -D --names); do
                wc="%{A:bspc desktop -f '^$w':} $w %{A}"
                if [[ "$FOCUSED" == "$w" ]]; then
                        echo -n "%{F#1d1f21}%{B#81a2be}$wc%{B-}%{F-}"
                elif [[ "$OCCUPIED" =~ "$w" ]]; then
                        echo -n "$wc"
                else
                        echo -n "%{F#969896}$wc%{F-}"
                fi
        done
}

echo "%{l}$(Workspaces)"
bspc subscribe desktop | while read line; do
        echo "%{l}$(Workspaces)"
done
