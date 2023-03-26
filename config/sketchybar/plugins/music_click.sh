#!/usr/bin/env bash

PLAYER_STATE=$(osascript -e "tell application \"Music\" to set playerState to (get player state) as text")
if [[ $PLAYER_STATE == "paused" ]]; then
    $(osascript -e "tell application \"Music\" to play")
fi

if [[ $PLAYER_STATE == "playing" ]]; then
    $(osascript -e "tell application \"Music\" to pause")
fi

sh $HOME/.config/sketchybar/plugins/music.sh

