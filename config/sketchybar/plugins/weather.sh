#!/bin/zsh

source $HOME/secret.sh

# TEMP=`curl -s "https://wttr.in/${LOCATION}?format=2"`
# echo $TEMP

QWEATHER_API="https://devapi.qweather.com/v7/weather/now?location=${LOCATION}&key=${QWEATHER_API_KEY}"
QWEATHER_AIR_API="https://devapi.qweather.com/v7/air/now?location=${LOCATION}&key=${QWEATHER_API_KEY}"
QWEATHER_AIR_API="https://devapi.qweather.com/v7/air/warning?location=${LOCATION}&key=${QWEATHER_API_KEY}"
QWEATHER_MINUTELY_API="https://devapi.qweather.com/v7/minutely/5m?location=${GEO_LOC}&key=${QWEATHER_API_KEY}"
weather=$(curl -L -X GET --compressed "${QWEATHER_API}")
air_quality=$(curl -L -X GET --compressed "${QWEATHER_AIR_API}")
weather_warnings=$(curl -L -X GET --compressed "${QWEATHER_WARNING_API}")

minutely=$(curl -L -X GET --compressed "${QWEATHER_MINUTELY_API}")
temp=$(echo $weather | jq -r '.now.temp')
icon=$(echo $weather | jq -r '.now.icon')
text=$(echo $weather | jq -r '.now.text')
feels_like=$(echo $weather | jq -r '.now.feelsLike')
wind_scale=$(echo $weather | jq -r '.now.windScale')
wind_speed=$(echo $weather | jq -r '.now.windSpeed')
wind_dir=$(echo $weather | jq -r '.now.windDir')
aqi=$(echo $air_quality | jq -r '.now.aqi')
minutely_summary=$(echo $minutely | jq -r '.summary')
warnings=$(echo $weather_warnings | jq -r '.warning | .[] | .type')
echo "warings: $warnings"

WEATHER_LABEL="${text} ${temp}(${feels_like})°C"
WEATHER_ICON=$($HOME/.config/sketchybar/plugins/weather_icons.sh $icon)

if [[ $wind_scale -gt 3 ]]; then
    WEATHER_LABEL="${WEATHER_LABEL} ${wind_dir}${wind_scale}级 ${wind_speed}m/s"
fi
if [[ $aqi -gt 50 ]]; then
    WEATHER_LABEL="${WEATHER_LABEL} AQI${aqi}"
fi
if [[ $minutely_summary != "未来两小时无降水" ]]; then
    WEATHER_LABEL="${WEATHER_LABEL} ${minutely_summary}"
fi
if [[ $warnings ]]; then
    WEATHER_LABEL="${WEATHER_LABEL} 有预警"
    for warning in $warnings; do
        WEATHER_ICON="${WEATHER_ICON} $($HOME/.config/sketchybar/plugins/weather_icons.sh $warning)"
    done
fi

echo $WEATHER_ICON
echo $WEATHER_LABEL

sketchybar --set temp label="${WEATHER_LABEL}" icon=${WEATHER_ICON}
