# Description:
#   Connect to ssh host and execute commands
#
# Dependencies:
#   ssh2
#   fs
#
# Configuration:
#   HUBOT_SSH2CMD_CFG - path of the configuration file
#
# Commands:
#   hubot ssh2cmd alias - makes ssh calls based on alias given
#
#
SSH2Shell = require 'ssh2shell'
fs = require 'fs'
ssh2cmd_cfg = process.env.HUBOT_SSH2CMD_CFG

module.exports = (robot) ->

  robot.respond /ssh2cmd ([\w\_\-]+)?\s?(.+)?/i, (msg) ->
    try
      config = fs.readFileSync ssh2cmd_cfg
      config_json = JSON.parse config
    catch
      msg.send "Unable to read config file #{ssh2cmd_cfg} for ssh2cmd"

    for key, value of config_json
      if value.server.privateKey
        try
          value.server.privateKey = require('fs').readFileSync(value.server.privateKey)
        catch
          msg.send "Unable to read file #{value.server.privateKey}"

      if key == msg.match[1]

        # argument replacement
        newCommands = []
        for commandKey, commandValue of value.commands
          newCommands.push commandValue.replace '$@', msg.match[2]

        value.commands = newCommands

        # loop through config objects and make ssh calls
        console.log "Openning connection to #{value.host}"
        console.log "Running the commands #{value.commands}"
        msg.send "Running the command alias #{key}"
        SSH = new SSH2Shell(value)

        callback = (sessionText) ->
          msg.send sessionText

        SSH.connect callback
