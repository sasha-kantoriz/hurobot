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
    child_process.exec 'crontab -l | sed "/^#.*#{device}*/s/^#//" | crontab -', (error, stdout, stderr) ->
      msg.send("enabled #{device} #{stdout} #{stderr}")

  robot.respond /disable (.*)/, (res) ->
    device = res.match[1]
    child_process.exec 'crontab -l | sed "/^[^#].*#{device}*/s/^/#/" | crontab -', (error, stdout, stderr) ->
      res.send("disabled #{device} #{stdout} #{stderr}")
