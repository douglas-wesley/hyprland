#!/bin/bash

STATUS=$(playerctl --player=spotify status 2>/dev/null)

if [[ "$STATUS" == "Playing" ]]; then
    TITLE=$(playerctl --player=spotify metadata title 2>/dev/null)
    ARTIST=$(playerctl --player=spotify metadata artist 2>/dev/null)
    echo "󰓇  $TITLE - $ARTIST"
elif [[ "$STATUS" == "Paused" ]]; then
    TITLE=$(playerctl --player=spotify metadata title 2>/dev/null)
    ARTIST=$(playerctl --player=spotify metadata artist 2>/dev/null)
    echo "󰏤  $TITLE - $ARTIST"
else
    echo ""
fi
