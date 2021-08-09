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

stop_recording() {
        trap - SIGTERM
        kill -SIGINT $pid 2>/dev/null
        notify-send -t 2000 -u low "Recording stopped"
        ffmpeg -i "$filemkv" -c:v libx264 -c:a aac "$filempg"
        notify-send -t 2000 -u low "Recording converted"
}

for i in "$@"; do
        if [[ "$i" == "microphone" ]]; then
                audioflags="-f alsa -ac 2 -i default"
                acodecflags="-c:a pcm_s16le"
                mode="$mode\nAudio enabled"
        elif [[ "$i" == "window" ]]; then
                windowflags="$(slop -D -f '-video_size %wx%h -i +%x,%y')"
                [[ -z "$windowflags" ]] && exit 1;
                mode="$mode\nSelected window"
        fi
done;

ffmpeg $audioflags $videoflags $windowflags $vcodecflags $acodecflags "$filemkv" &
pid=$!

trap stop_recording SIGTERM

notify-send -t 2000 -u low "Recording started" "$mode"

wait $pid
