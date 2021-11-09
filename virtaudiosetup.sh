#!/bin/sh

SPEAKER="@DEFAULT_SINK@"
# MICROPHONE="alsa_input.usb-MICE_MICROPHONE_USB_MICROPHONE_201308-00.mono-fallback"
MICROPHONE="PulseEffects_mic.monitor"

pactl load-module module-null-sink sink_name=duplexin sink_properties=device.description="DuplexIn" 
pactl load-module module-null-sink sink_name=duplexout sink_properties=device.description="DuplexOut"

pactl load-module module-loopback source=duplexin.monitor sink=$SPEAKER latency_msec=60 adjust_time=6
pactl load-module module-loopback source=duplexin.monitor sink=duplexout latency_msec=60 adjust_time=6
pactl load-module module-loopback source=$MICROPHONE sink=duplexout latency_msec=60 adjust_time=6
