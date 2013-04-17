#!/bin/bash

case "$1" in
    unmute)
        amixer -c 0 set Master unmute 
        ;;
    mute)
        amixer -c 0 set Master mute 
        ;;
    up)
        amixer -c 0 set Master 10%+ unmute
        ;;
    down)
        amixer -c 0 set Master 10%- unmute
        ;;
esac

