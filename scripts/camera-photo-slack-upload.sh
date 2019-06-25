#!/bin/bash

output_directory=/camera
output_file=`TZ=Europe/Kiev date +%Y-%m-%d.%H-%M-%S`.jpeg
export TZ=Europt/Kiev

raspistill -t 1000 -o $output_directory/$output_file #-h 420 -w 510

curl -F "file=@$output_directory/$output_file" -F 'channels=#random' -F "token=$HUBOT_SLACK_TOKEN" https://slack.com/api/files.upload

