#!/bin/bash
logfile=/Users/kandyala.intern/Desktop/access.log
logfile1=/Users/kandyala.intern/Desktop/access.log
write_file=record.txt

printf "\nHighest Requested Hosts, Upstream IP's and Paths Date-Wise : \n"
highest_requested (){
    date=$1
	cat $logfile | grep $date | awk '{print $NF}' | sort | uniq -c | sort -r | head -1 > $write_file
    host_times=$(awk '{print $1}' $write_file)
	host_name=$(awk '{print $2}' $write_file)
    
    cat $logfile | grep $date | awk '{print $9}' | sort | uniq -c | sort -r | head -1 > $write_file
    upstream_ip_times=$(awk '{print $1}' $write_file)
	upstream_ip=$(awk '{print $2}' $write_file)

    cat $logfile | grep $date | awk '{print $5}' | sort | uniq -c | sort -nr | head -1 > $write_file
    path_times=$(awk '{print $1}' $write_file)
    path=$(awk '{print $2}' $write_file)

  
    printf "On $date \n"
    echo "$host_name was the highest requested  and it was requested  $host_times times. "
	echo "$upstream_ip was the highest requested upstream_ip and it was requested $upstream_ip_times times. "
    echo "$path was highest requested path and it was requested $path_times times. "
    #printf "\n\n"
}

