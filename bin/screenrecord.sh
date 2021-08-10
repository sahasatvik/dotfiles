#!/usr/bin/bash

filename="recording-$(date +%s)"
folder="$HOME/Videos/screenrecords"
filemkv="${folder}/lossless/${filename}.mkv"
filempg="${folder}/${filename}.mp4"
mode=""
pid=""

videoflags="-framerate 30 -f x11grab"
audioflags=""
windowflags="-video_size 1920x1080 -i :0.0"
vcodecflags="-c:v ffv1 -preset ultrafast"
acodecflags=""

PANEL_FIFO=/tmp/panel-fifo

stop_recording() {
        trap - SIGTERM
        kill -SIGINT $pid 2>/dev/null
        notify-send -t 2000 -u low "Recording stopped"
        echo "Rprocessing" > "$PANEL_FIFO"
        ffmpeg -i "$filemkv" -af 'lowpass=3000, highpass=200, afftdn=tn=enabled' -c:v libx264 -c:a aac "$filempg"
        echo "Rdone" > "$PANEL_FIFO"
        notify-send -t 2000 -u low "Recording ready"
}

for i in "$@"; do
        if [[ "$i" == "microphone" ]]; then
                pacmd set-default-source alsa_input.pci-0000_00_1f.3.analog-stereo
                audioflags="-f alsa -ac 2 -i default"
                acodecflags="-c:a pcm_s16le"
                mode="$mode\nMicrophone audio"
        elif [[ "$i" == "desktop" ]]; then
                pacmd set-default-source alsa_output.pci-0000_00_1f.3.analog-stereo.monitor
                audioflags="-f alsa -ac 2 -i default"
                acodecflags="-c:a pcm_s16le"
                mode="$mode\nDesktop audio"
        elif [[ "$i" == "window" ]]; then
                windowflags="$(slop -D -f '-video_size %wx%h -i +%x,%y')"
                [[ -z "$windowflags" ]] && exit 1;
                mode="$mode\nSelected window"
        fi
done;

ffmpeg $audioflags $videoflags $windowflags $vcodecflags $acodecflags "$filemkv" &
pid=$!

trap stop_recording SIGTERM

echo "Rstarted" > "$PANEL_FIFO"
notify-send -t 2000 -u low "Recording started" "$mode"

wait $pid
