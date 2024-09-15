#!/usr/bin/bash

get_work_space_focus_arr () {
	workspace_output_json=$(swaymsg -t get_workspaces -r)
	workspaces=$(echo $workspace_output_json | jq -r ".[].focused")
	declare -a ws_stats=()
	for ws_focus in $workspaces; do
		if [ "$ws_focus" = "true" ]; then
			ws_stats+=(1)
		else
			ws_stats+=(0)
		fi
	done
	echo ${ws_stats[@]}
}

format_yuck_component_literal () {
	focused=$1
	icon=""
	if (( $focused == 1 )); then
		icon="󰣏"
	else 
		icon="󱀝"
	fi
	echo "(workspace :icon '$icon')"
}

print_yuck_lit () {
	literal=""
	for ws_stat in $(get_work_space_focus_arr); do
		literal+=$(format_yuck_component_literal $ws_stat)
		literal+=$(echo " ")
	done
	echo "(box $literal)"
}

echo $(print_yuck_lit)

