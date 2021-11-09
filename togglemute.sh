#!/bin/sh

mic=$(pactl info | grep "Default Source: " | cut -d' ' -f3)
state=$(pactl list | grep -E "Name: $mic$|Mute" | grep "Name: " -A1 | tail -1 | cut -d% -f1 | cut -d' ' -f2)

if [ "$state" = "yes" ]; then
    # Currently muted
    pactl set-source-mute "$mic" 0
    mpv "$HOME/.config/scripts/sounds/on.mp3" --really-quiet > /dev/null
else
    # Currently unmuted
    pactl set-source-mute "$mic" 1
    mpv "$HOME/.config/scripts/sounds/off.mp3" --really-quiet > /dev/null
fi
