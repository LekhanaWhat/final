#!/bin/bash
logfile=/home/flask/final/access.log
logfile1=/home/flask/final/access.log
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
