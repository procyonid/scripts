#!/bin/sh


separator="#"

input=$(zenity --forms --text="" --separator="${separator}" --add-entry="URL" --add-entry="Title" --add-entry="Artist" --add-entry="Album")
[ "$(echo "$input" | tr -cd $separator | wc -c)" = "3" ] || exit


url=$(echo $input | cut -d"${separator}" -f1)
title=$(echo $input | cut -d"${separator}" -f2)
artist=$(echo $input | cut -d"${separator}" -f3)
album=$(echo $input | cut -d"${separator}" -f4)

if [ -z "$url" ]; then
    exit
fi


tmpname="tmp.audiodl"
youtube-dl -f bestaudio "$url" -o "/tmp/$tmpname.%(ext)s"
tmppath="/tmp/$(ls /tmp | grep "$tmpname")"

case "$tmppath" in
    *.webm|*.m4a)
        ffmpeg -i "$tmppath" -vn -ab 128k -ar 44100 -y "/tmp/${tmpname}.mp3"
        rm "$tmppath"
    ;;
    *.mp3)
        echo "mp3"
    ;;
    *)
        echo "fuck"
        exit
    ;;
esac


args=$( [ -n "$title" ] && echo "-t \"$title\" ")
args="$args $( [ -n "$artist" ] && echo "-a \"$artist\" ")"
args="$args $( [ -n "$album" ] && echo "-A \"$album\" ")"


[ -n "$args" ] && eval "id3v2 $args \"/tmp/${tmpname}.mp3\""

mp3name "/tmp/${tmpname}.mp3"

notify-send "AudioDL" "Finished downloading $title"
