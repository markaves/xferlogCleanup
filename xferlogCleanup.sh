#!/usr/bin/bash
#Name: Xferlog cleanup
#Description:  This script will delete log entries from x days.  This is for SunOS.
#Created By:  Mark Aves
#Date: 2015-09-11

LOGDIR=/var/log
xfertlog=$LOGDIR/xferlog

now=`perl -e 'print time."\n"'`
past=$(($now-5184000))
past_date=`perl -le 'print scalar localtime $ARGV[0]' $past | cut -d" " -f1,2,3`

last_location=`grep -n "$past_date" $xfertlog | tail -1 | cut -d":" -f1`
total=`wc -l xferlog | tr -s ' ' | cut -d" " -f2`
last_lines=$(($total-$last_location))

tail -n $last_lines $xfertlog > $LOGDIR/xfertemplog
