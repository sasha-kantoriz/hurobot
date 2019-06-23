# Description:
#   Attempt to control the growing process
#
# Commands:
#   do <on,off,check> <device> - Switch the devices under control (e.g. lights, coolers)
#
#   screenshot - Grab a photo of inside view
#
#   list crons - Print out list of crontab actions
#
#   enable <device> - Enable timed controling of device via crontab
#
#   disable <device> - Disable timed controling of device via crontab
#
#   play - Start audio player
#
#   mute - Mute audio player
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

  robot.respond /play (.*)/, (msg) ->
    path = if msg.match[1] then msg.match[1] else '/music'
    #path = msg.match[1]
    child_process.exec "(play -q /music/*.mp3", (error, stdout, stderr) ->
      msg.send("started music player at path #{path}\n#{stdout}\n#{stderr}")

  robot.respond /mute/, (msg) ->
    child_process.exec "killall play", (error, stdout, stderr) ->
      msg.send("mute music player\n#{stdout}\n#{stderr}")


