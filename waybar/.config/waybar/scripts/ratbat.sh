#!/usr/bin/env bash

mouse="$(upower -e | grep battery)"
mousePercentage=""
keyboard="$(upower -e | grep keyboard)"
keyboardPercentage=""
headphone="$(upower -e | grep headphone)"
headphonePercentage=""



printdots() {
  state="ok";
  offdot="<span foreground='grey'>$dot</span>"

  dot1="$dot"
  dot2="$dot"
  dot3="$dot"
  
    if [ "$1" -le "10" ]; then
      state="critical"
    else
    if [ "$1" -lt "33" ]; then
      dot2="$offdot"
    fi
    if [ "$1" -lt "66" ]; then
      dot3="$offdot"
    fi
  fi
 
  printf "{ \"text\": \"󰏳 $1%% 󰍽 \", \"tooltip\": \"Softy: $1%%\", \"class\": \"$state\" }\n"
}

if [ -n "$mouse" ]; then
  perc="$(upower -i $mouse | grep percentage | awk '{print $2}')"

  printdots "${perc%?}"
fi

# This is done to kill upower upon exit
upower -m > >(while read -r line ; do
    if [[ "$line" == *"$mouse"* || "$line" == *"$keyboard"* || "$line" == *"$headphone"* ]]; then
        # if [ "$(echo $line | awk '{print $3}')" = "removed:" ]; then
        #     printf "{ \"text\": \"󰏳  \" }\n"
        # else
        #     mouseName="$(echo $line | awk '{print $4}')"
        #     perc="$(upower -i $mouseName | grep percentage | awk '{print $2}')"
        #     printdots "${perc%?}"
        # fi 

    fi


done)
echo "should exit"
wait $!

