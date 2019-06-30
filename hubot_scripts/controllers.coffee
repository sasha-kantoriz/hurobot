# Description:
#   Attempt to control the growing process
#
# Commands:
#   hurogun do <on,off,check> <device> - Switch the devices under control (e.g. lights, coolers)
#
#   hurogun screenshot - Grab a photo of inside view
#
#   hurogun list crons - Print out list of crontab actions
#
#   hurogun enable <device> - Enable timed controling of device via crontab
#
#   hurogun disable <device> - Disable timed controling of device via crontab
#
#   hurogun download <url> - Download and add to tracklist audio or whole playlist by Youtube link
#
#   hurogun play - Start audio player
#
#   hurogun mute - Mute audio player
#
# Author:
#   hts


fs = require("fs")
request = require("request")

child_process = require('child_process')
module.exports = (robot) ->

  robot.respond /do (.*) (.*)/, (res) ->
    device = res.match[2]
    action = res.match[1]
    child_process.exec "python3 /scripts/pigpio-controller.py #{action} #{device}", (error, stdout, stderr) ->
      res.send("#{stdout}, #{stderr}")

  robot.respond /screenshot/, (msg) ->
    child_process.exec 'bash /scripts/camera-photo-slack-upload.sh', (error, stdout, stderr) ->
      msg.send("Here is photo #{stdout}, #{stderr}")

  robot.respond /list crons/, (msg) ->
    child_process.exec 'crontab -l', (error, stdout, stderr) ->
      msg.send("Crontab entries:\n#{stdout}\n#{stderr}")

  robot.respond /enable (.*)/, (msg) ->
    device = msg.match[1]
    child_process.exec "/scripts/timer-manager.sh enable #{device}", (error, stdout, stderr) ->
      msg.send("enabled #{device}\n#{stdout} #{stderr}")

  robot.respond /disable (.*)/, (res) ->
    device = res.match[1]
    child_process.exec "/scripts/timer-manager.sh disable #{device}", (error, stdout, stderr) ->
      res.send("disabled #{device}\n#{stdout} #{stderr}")

  robot.respond /download (.*)/, (res) ->
    youtube_url = res.match[1]
    child_process.exec "python3 /scripts/listen_that.py download #{youtube_url}", (error, stdout, stderr) ->
      res.send("added to music library #{youtube_url}\n#{stdout}\n#{stderr}")

  robot.respond /play/, (msg) ->
    child_process.exec "python3 /scripts/listen_that.py &> /dev/null", (error, stdout, stderr) ->
      msg.send("started music player at path #{path}\n#{stdout}\n#{stderr}")

  robot.respond /mute/, (msg) ->
    child_process.exec "killall play", (error, stdout, stderr) ->
      msg.send("muted music player\n#{stdout}\n#{stderr}")


