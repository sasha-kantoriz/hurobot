FROM balenalib/raspberrypi3-debian-node

RUN apt update -y &&\
    apt-get install -y gcc cron curl python3 python3-setuptools python3-pip python3-dev pigpio python3-pigpio npm nodejs 

#RUN pip install RPi.GPIO

## Hubot
RUN npm install -g coffee-script yo generator-hubot && \
    npm install hubot-standup-alarm hubot-slack --save && npm install

# add hubot user
RUN useradd -d /hubot -m -s /bin/bash -U hubot

# Log in as hubot user and change directory
# USER hubot
WORKDIR /hubot

# Install hubot
RUN su hubot -c 'yo hubot --owner="You" --name="HuBot" --description="HuBot on Docker" --defaults'

CMD pigpiod && env > /etc/.environment && cron /etc/cron.d/cron-dev && cd /hubot && bin/hubot -a slack
