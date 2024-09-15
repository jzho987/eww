#!/usr/bin/bash

audio_cmd_output_c=""
while true; do
	audio_cmd_output=$( pulsemixer --get-volume )
	mean_vol=0
	total_nums=0
	for vol in $audio_cmd_output; do
		mean_vol=$(( $mean_vol + $vol ))
		total_nums=$(( $total_nums + 1 ))
	done
	mean_vol=$(( $mean_vol / $total_nums ))

	if [[ $audio_cmd_output_c != $audio_cmd_output ]]; then
		audio_cmd_output_c=$audio_cmd_output
		echo $mean_vol
	fi
	sleep 1
done
