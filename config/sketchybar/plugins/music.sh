sleep 1

if [[ -z $NAME ]]; then
    NAME=music
fi

APP_STATE=$(pgrep -x Music)
if [[ ! $APP_STATE ]]; then 
    echo "Music process doesn't exist."
    sketchybar -m --set $NAME label.drawing=off icon.drawing=off
    exit 0
fi
PLAYER_STATE=$(osascript -e "tell application \"Music\" to set playerState to (get player state) as text")
if [[ $PLAYER_STATE == "stopped" ]]; then
    echo "Music has been stopped."
    sketchybar --set $NAME label.drawing=off icon.drawing=off
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
	echo "Music is playing~"
	sketchybar --set $NAME label.drawing=on icon.drawing=on
	sketchybar --set $NAME icon="$icon" label="$PLAYING - $artist"

else
    echo "Music is not playing~"
	sketchybar --set $NAME label.drawing=off icon.drawing=off
fi
