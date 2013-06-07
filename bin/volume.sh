#!/bin/sh

if [ -z '$SOUND_CARD_ID' ]; then
SOUND_CARD_ID=0
fi

if [ -z '$SOUND_CARD_CHANNEL' ]; then
SOUND_CARD_CHANNEL="Master"
fi

case "$1" in
    toggle)
        amixer -q -c $SOUND_CARD_ID set $SOUND_CARD_CHANNEL toggle 
        ;;
    unmute)
        amixer -q -c $SOUND_CARD_ID set $SOUND_CARD_CHANNEL unmute 
        ;;
    mute)
        amixer -q -c $SOUND_CARD_ID set $SOUND_CARD_CHANNEL mute 
        ;;
    up)
        amixer -q -c $SOUND_CARD_ID set $SOUND_CARD_CHANNEL 5%+ unmute
        ;;
    down)
        amixer -q -c $SOUND_CARD_ID set $SOUND_CARD_CHANNEL 5%- unmute
        ;;
esac

