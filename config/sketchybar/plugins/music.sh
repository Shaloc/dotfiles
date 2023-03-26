sleep 0.5

APP_STATE=$(pgrep -x Music)
if [[ ! $APP_STATE ]]; then 
    sketchybar -m --set $NAME drawing=off
    exit 0
fi
PLAYER_STATE=$(osascript -e "tell application \"Music\" to set playerState to (get player state) as text")
if [[ $PLAYER_STATE == "stopped" ]]; then
    sketchybar --set music drawing=off
    exit 0
fi

PLAYING=$(osascript -e 'tell application "Music" to get name of current track')

if [[ $PLAYING != "None" ]]; then
    artist=$(osascript -e 'tell application "Music" to get artist of current track')
	PLAYER_STATE=$(osascript -e "tell application \"Music\" to set playerState to (get player state) as text")
	if [[ $PLAYER_STATE == "paused" ]]; then
		icon="􀊘"
	fi
	if [[ $PLAYER_STATE == "playing" ]]; then
		icon="􀊖"
	fi
	sketchybar --set $NAME label.drawing=on icon.drawing=on
	sketchybar --set $NAME icon="$icon" label="$PLAYING - $artist"

else
	sketchybar --set $NAME label.drawing=off icon.drawing=off
fi
