#!/usr/bin/bash

battery_icons=("󰂃" "󰁺" "󰁻" "󰁻" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" "󰂄")
battery_level_c=""
battery_status_C=""

while true; do
	battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
	battery_status=$(cat /sys/class/power_supply/BAT0/status)

	battery_icon=${battery_icons[0]}
	if [ $battery_status = "Discharging" ]; then
		index=$(( (battery_level / 10) ))
		battery_icon=${battery_icons[$index]}
	else
		battery_icon=${battery_icons[-1]}
	fi

	if [[ $battery_level_c != $battery_level ]] || [[ $battery_status_c != $battery_status ]]; then
		battery_level_c=$battery_level
		battery_status_c=$battery_status
		echo $battery_level% $battery_icon
	fi
	sleep 1;
done
