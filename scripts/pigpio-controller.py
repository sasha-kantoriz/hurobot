#/usr/bin/python3
import os, sys, datetime
import pigpio
from slackclient import SlackClient


def slack_notify(client, text, channel='#services', user=None):
    client.api_call(
      "chat.postMessage",
      channel=channel,
      text=text,
      user=user
    )

# GPIO logic via Normaly Closed relay contact
def check(pi, pin): return int(not pi.read(pin))

def on(pi, pin):
    pi.write(pin, 0)
    return 1

def off(pi, pin):
    pi.write(pin, 1)
    return 0

def switch(pi, pin, to_state=None):
    if to_state:
        pi.write(pin, to_state)
    else:
        to_state = int(not bool(pi.read(pin)))
        pi.write(pin, to_state)
    return to_state
#

def init(host='localhost', port=8888):
    pi = pigpio.pi(host, port)
    return pi

def get_args():
    # action (switch,check,on,off) device (lights, coolers)
    try:
        action_arg = sys.argv[1]
        action = config['actions'][action_arg]
    except:
        print('arg :action is missing or not recognized')
        exit(1)
    try:
        device_arg = sys.argv[2]
        device = config['pins'][device_arg]
    except:
        print('arg :device is missing or not recognized')
        exit(1)
    notification = "[{}] result of {} {} is: ".format(datetime.datetime.now(), action_arg, device_arg)
    return action, device, notification


config = {
    'pins': {
      'lights': 3,
      'coolers': 2
    },
    'actions': {
       'on': on,
       'off': off,
       'switch': switch,
       'check': check
    },
}


if __name__ == '__main__':
    pi_board = init()
    action, device, notification = get_args()
    slack_token = os.environ.get("HUBOT_SLACK_TOKEN", None)
    try:
        sc = SlackClient(slack_token)
    except:
        sc = None
        print('No slack token available')
    notification += str(action(pi_board, device))
    print(notification)
    if sc:
        slack_notify(sc, notification)

