#!/usr/bin/env sh

essids() {
        iwconfig wlp2s0 \
                | grep -oe "ESSID:[^ ]*" \
                | sed "s/ESSID://g" \
                | tr -d \"
}


essid="$(essids)"
if [[ ! "$essid" =~ "off" ]]; then
        echo $essid
fi
