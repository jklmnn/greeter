#!/bin/bash

if [ $(whoami) != "root" ]
then
	echo runme as root
	exit 1
fi

if [ $# -lt 2 ]
then
	echo "Usage: $0 <IP range> <audio user>"
	exit 1
fi

if [ ! -e /usr/bin/nmap ]
then
	echo nmap not found
	exit 1
fi

if [ ! -e /usr/bin/espeak ]
then
	echo espeak not found
	exit 1
fi

rundir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

nmap -sn -PR -T4 $1 -oX - | grep -oE "([0-9A-F]{2}:){5}[0-9A-F]{2}" > $rundir/isonline

while IFS='' read -r line || [[ -n "$line" ]]; do
	cat $rundir/wasonline[0-3] 2>/dev/null | grep $line > /dev/null
	if [ $? -eq 1 ]
	then
		nameline=$(cat $rundir/namelist | grep $line)
		if [ $? -eq 0 ]
		then
			name=$(echo $nameline | cut -d";" -f2)
			echo $(date) Greeting $name >> $rundir/logfile
			su $2 -s /bin/bash -c "espeak \"Hello $name\""
		fi
	fi
done < $rundir/isonline

cat $rundir/wasonline2 > $rundir/wasonline3 2>/dev/null
cat $rundir/wasonline1 > $rundir/wasonline2 2>/dev/null
cat $rundir/wasonline0 > $rundir/wasonline1 2>/dev/null
cat $rundir/isonline > $rundir/wasonline0 2>/dev/null
