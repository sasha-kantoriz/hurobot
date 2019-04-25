docker run -d --name hubot \
	--restart always -it -u root \
	-v `pwd`/scripts:/scripts \
	-v `pwd`/hubot_scripts:/hubot/scripts \
	-v photos_output:/mnt/d-usb/data/local/camera \
	--device=/dev/vcsm \
	--device=/dev/vchiq \
	--device /dev/gpiomem \
	-e HUBOT_SLACK_TOKEN=$SLACK_TOKEN \
	local/hubot:latest bash -c 'cron && pigpiod && cd /hubot && bin/hubot -a slack'
