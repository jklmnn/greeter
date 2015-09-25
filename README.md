# greeter
Script that greets people who enter a network.


## Requirements
* Bash
* nmap
* espeak

## Installation
* choose a device that is always online (e.g. Raspberry Pi)
* put all files in a folder (the script will create some additional files in this folder)
* create a file named `namelist` in that folder where you put the MAC and the name of everyone you want to greet (see `namelist.example`)
* add the file to cron, example: `*/5 * * * * root /path/greeter.sh 192.168.0.0/24 user`
* the script takes two arguments: ip range and a user that can play audio
