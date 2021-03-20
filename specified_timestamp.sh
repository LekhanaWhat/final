#!/bin/bash
logfile=/Users/kandyala.intern/Desktop/access.log
logfile1=/Users/kandyala.intern/Desktop/access.log
write_file=record.txt

specified_timestamp(){
    fromdate=$1
    fromtime=$2
    todate=$3
    totime=$4

    from=$fromdate:$fromtime
    to=$todate:$totime
    # echo $from
    # echo $to
    cat $logfile | grep "$from\|$to"
    # cat $logfile | sed -n "/$from/, /$to/p"
}

# specified_timestamp 12/Feb/2021 06:53:04  12/Feb/2021 06:52:05