#!/bin/zsh

source $HOME/secret.sh

# TEMP=`curl -s "https://wttr.in/${LOCATION}?format=2"`
# echo $TEMP
icon_result=""

LOCATION="101010300" # Chaoyang,Beijing
QWEATHER_API="https://devapi.qweather.com/v7/weather/now?location=${LOCATION}&key=${QWEATHER_API_KEY}"
weather=$(curl -L -X GET --compressed "${QWEATHER_API}")
temp=$(echo $weather | jq -r '.now.temp')
icon=$(echo $weather | jq -r '.now.icon')
text=$(echo $weather | jq -r '.now.text')
feels_like=$(echo $weather | jq -r '.now.feelsLike')
wind_scale=$(echo $weather | jq -r '.now.windScale')
wind_speed=$(echo $weather | jq -r '.now.windSpeed')
wind_dir=$(echo $weather | jq -r '.now.windDir')


WEATHER_LABEL="${text} ${temp}(${feels_like})°C ${wind_dir}${wind_scale}级"
WEATHER_ICON=$($HOME/.config/sketchybar/plugins/weather_icons.sh $icon)
echo $WEATHER_ICON
echo $WEATHER_LABEL

sketchybar --set temp label="${WEATHER_LABEL}" icon=${WEATHER_ICON}
