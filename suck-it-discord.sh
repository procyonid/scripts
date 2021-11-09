#!/bin/sh
tmpfile="$HOME/Downloads/tmp.gif"
touch "$tmpfile"


if ! xclip -sel c -o -t image/png; then
	notify-send "ERROR" "No image data found"
	exit 1
fi

convert <(xclip -sel c -o -t image/png) -channel A -threshold 15% gif:"$tmpfile"
dragon-drag-and-drop "$tmpfile" --and-exit
sleep 15
rm "$tmpfile"
