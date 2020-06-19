# hubot-ssh2cmd

Hubot to run ssh commands

## Installation

In your hubot repository, run:

`npm install hubot-ssh2cmd --save`

Then add **hubot-ssh2cmd** to your `external-scripts.json`:

```json
["hubot-ssh2cmd"]
```

## Configuration

| Environment Variable | Required? | Description                               |
| -------------------- | --------- | ----------------------------------------- |
| `HUBOT_SSH2CMD_CFG` | Yes | Config file of ssh hosts, passwords, keys, commands, etc. |


Example json configuration of alias dictionary along with server definitions.

```json
{
    "ls": { 
        "server":        { 
            "host":         "127.0.0.1",
            "userName":     "username",
            "privateKey":   "/home/user/.ssh/id_rsa"
            },
        "commands":      [ "ls -l" ]
    },
    "date": { 
        "server":        { 
            "host":         "127.0.0.1",
            "userName":     "username",
            "privateKey":   "/home/user/.ssh/id_rsa"
            },
        "commands":      [ "date" ]
    }
}
```

More advanced configurations are allowed and can be found at https://github.com/cmp-202/ssh2shell

## Example interactions

Trigger an alias that contains predefined ssh commands:

```
myhubot> myhubot ssh2cmd date
myhubot> Connected
Ready
127.0.0.1: date
Thu May 28 03:27:16 UTC 2020
[dpeng@centos ~]$
```
## Resources

* https://github.com/cmp-202/ssh2shell