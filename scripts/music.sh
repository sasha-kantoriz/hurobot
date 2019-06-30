#!/bin/bash

music_folder_path=/music/all
tracklist=/music/tracklist.txt
timestamp=`TZ=Europe/Kiev date +%Y-%m-%d.%H-%M-%S`

case $1 in
	download)
		touch $tracklist
		mkdir -p /music/$timestamp
		cd /music/$timestamp
		youtube-dl -x --audio-format=mp3 $2
		for t in *.mp3; do
			new_track_filename="$music_folder_path/$RANDOM+`date +%Y-%m-%d.%H-%M-%S`.mp3";
			mv "${t}" "${new_track_filename}";
			echo "${t}  ->  ${new_track_filename}" >> $tracklist;
		done
	;;
	play)
		bash -i -c "(play -q `ls $music_folder_path/*.mp3 | sort -R`) &"
	;;
	*)
		bash -i -c "(play -q `ls $music_folder_path/*.mp3 | sort -R`) &"
	;;
esac

