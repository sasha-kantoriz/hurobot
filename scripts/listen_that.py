#/usr/bin/python3
import os
import sys
from datetime import datetime
from pytz import timezone


global tz
global timestamp

global music_folder_path
global downloads_folder
global tracklist_file
global player_controller


tz = timezone('Europe/Kiev')
timestamp = datetime.now(tz=tz).isoformat()

music_folder_path = '/music/all'
downloads_folder = '/music/downloads'
tracklist_file = '/music/tracklist'
player_controller = '/scripts/music.sh'


def download(url):
    destination_dir = os.path.join(downloads_folder, timestamp)
    try:
        os.system('/bin/bash {} download {}'.format(player_controller, url))
    except Exception as e:
        print('[Error {}] - While starting to download <{}>'.format(timestamp, url))
        print(e)

def play():
    os.system('/bin/bash {} play'.format(player_controller))

def stop_player():
    os.system('killall play')

def volume_control(operation, value):
    log_text = '[VOLUME Update {}] - %s by {}'.format(timestamp, value)
    if operation == '+':
        log_text = log_text % 'raised'
    elif operation == '-':
        log_text = log_text % 'decreased'
    else:
        print('[VOLUME Error {}] - Unknown operation'.format(timestamp))
        exit()
    print(log_text)


if __name__ == '__main__':
    try:
        cmd = sys.argv[1]
        if cmd == 'play':
            play()
        elif cmd == 'download':
            try:
                url = sys.argv[2]
            except Exception as e:
                print('[Error {}] with args for download command'.format(timestamp))
                print(e)
            download(url)
        elif cmd == 'mute':
            stop_player()
        elif cmd == 'volume':
            operation = sys.argv[2]
            value = sys.argv[3]
            volume_control(operation, value)
        else:
            raise Exception(message='Arguments are not recognized')
    except Exception as e:
        print('[Error {}] While getting args - Starting audio player by default'.format(timestamp))
        print(e)
        play()




