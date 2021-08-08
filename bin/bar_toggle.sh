#!/usr/bin/env sh

if { pkill -x bar_clock.sh && pkill -x bar_spaces.sh && pkill -x lemonbar; }; then
        bspc config top_padding 0
else
        ~/bin/bar_clock.sh  | lemonbar -pd -F "#DDDDDD" -B "#1D1F21" -f "Fira Mono-10" -g 180x24+1740 &
        ~/bin/bar_spaces.sh | lemonbar -pd -F "#DDDDDD" -B "#1D1F21" -f "Fira Mono-10" -g 220x24 | sh &
        
        bspc config top_padding 24
        xdo above -t "$(xdo id -n root)" "$(xdo -n lemonbar)"
fi
