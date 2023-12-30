#!/usr/bin/env bash

# Global variables for battery percentages
mousePercentage=""
keyboardPercentage=""
headphonePercentage=""
notConnected=""

update_battery_level() {
  deviceName=$1
  deviceType=$2
  remove=$3
  # Updating the global variable based on device type
  if [ -n "$deviceName" ]; then
    perc="$(upower -i "$deviceName" | grep percentage | awk '{print $2}')"
    perc="${perc%?}" # Remove the '%' character
    case $deviceType in
      Mouse)
        if $remove ; then
            mousePercentage=$notConnected
        fi
        mousePercentage=$perc
        ;;
      Keyboard)
        if [[ "$remove" = true ]]; then
            keyboardPercentage=""
        fi
        keyboardPercentage=$perc
        ;;
      Headphone)
        if [[ "$remove" = true ]]; then
            headphonePercentage=""
        fi
        headphonePercentage=$perc
        ;;
    esac
    printf "{ \"text\": \"󰏳 $headphonePercentage%%  $keyboardPercentage%% 󰍽 $mousePercentage%%\", \"tooltip\": \"\" }\n"
  else
    printf "{ \"text\": \"󰏳 $headphonePercentage%%  $keyboardPercentage%% 󰍽 $mousePercentage%%\", \"tooltip\": \"\" }\n"
  fi
}


mouse="$(upower -e | grep battery)"
keyboard="$(upower -e | grep keyboard)"
headphone="$(upower -e | grep headphone)"
removeMouse=true
removeKeyboard=true
removeHeadphone=false

if [ -n "$mouse" ]; then
    removeMouse=true
fi

if [ -n "$keyboard" ]; then
    removeKeyboard=true
fi

if [ -n "$headphone" ]; then
    removeHeadphone=true
fi

update_battery_level "$mouse" "Mouse" "$removeMouse"
update_battery_level "$keyboard" "Keyboard" "$removeKeyboard"
update_battery_level "$headphone" "Headphone" "$removeHeadphone"

# Monitoring battery status
upower -m > >(while read -r line ; do
    mouse="$(upower -e | grep battery)"
    keyboard="$(upower -e | grep keyboard)"
    headphone="$(upower -e | grep headphone)"
    remove=false
    if [ "$(echo $line | awk '{print $3}')" = "removed:" ]; then
        echo "there is somehting removed"
        remove=true
    fi
    
    if [[ "$line" == *"$mouse"* ]]; then
        update_battery_level "$mouse" "Mouse" "$remove"
    elif [[ "$line" == *"$keyboard"* ]]; then
        update_battery_level "$keyboard" "Keyboard" "$remove"
    elif [[ "$line" == *"$headphone"* ]]; then
        update_battery_level "$headphone" "Headphone" "$remove"
    fi

done)
echo "should exit"
wait $!
