docker run -d --name hubot \
	--restart always -it -u root \
	-v `pwd`/scripts:/scripts \
	-v `pwd`/hubot_scripts:/hubot/scripts \
        -v `pwd`/cron-dev:/etc/cron.d/cron-dev \
	-v photos_output:/camera \
        --cap-add SYS_RAWIO \
        --device /dev/mem \
        --device /dev/vcio \
	--device=/dev/vcsm \
	--device=/dev/vchiq \
	--device /dev/gpiomem \
        -p '127.0.0.1:8888:8888' \
	-e HUBOT_SLACK_TOKEN=$SLACK_TOKEN \
	local/hubot:latest bash -c "pigpiod && env > /etc/.environment && cron /etc/cron.d/cron-dev && cd /hubot && bin/hubot -a slack"

