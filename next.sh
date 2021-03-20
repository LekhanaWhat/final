#!/bin/bash
logfile=/home/flask/final/access.log
logfile1=/home/flask/final/access.log
write_file=record.txt




printf "<div class=\"cardn\">"
printf "<h3> 2.Total Requests per status code:</h3>"
cat $logfile | awk '{print $7}' | sort | uniq -c > $write_file
while read line; do
	set -- $line
	printf "<b>Total requests on status code</b> $2 : $1\n\n"
done < $write_file
printf "</div>"

top_5_requested() {
    awkval=$1
    name=$2

    cat $logfile | awk '{print $'$awkval'}' | sort | uniq -c | sort -nr | head -5 > $write_file
    # cat $logfile | awk '{print $9}' | sort | uniq -c | sort -nr | head -5 > $write_file
    printf "<div class=\"cardn\">"
    printf "<h3>3.Top 5 Requested $name:</h3>"

    while read line; do
	    set -- $line
	    printf "$name : $2 requested $1 times.\n\n"
    done < $write_file
    printf "</div>"

}

top_5_requested 9 Upstream_ip
top_5_requested NF Host
top_5_requested 10 BodyBytesSent
top_5_requested 5 Path

high_5_response(){
    cat $logfile | awk '{print $8, $NF}' | sort -nr | uniq | head -5 > $write_file
    printf "<div class=\"cardn\">"
    printf "<h3>Top 5 Requested Response:</h3>"

    while read line; do
	    set -- $line
	    echo "<b>Response Time :</b> $1    |||   <b>requested by:</b> $2  |||  <b>requested from:</b> $3 IP."
    done < $write_file
    printf "</div>"
}

high_5_response 


high_5_req_stat(){
    cat $logfile | awk '{print $7, $NF}' | sort | uniq -c| sort -nr | head -5 > $write_file
    printf "<div class=\"cardn\">"
    printf "\n\n<h3>Top 5 Requested Paths:</h3>\n"
    

    while read line; do
        set -- $line
        printf "<strong>Status Code :</strong> $2    |||   <strong>Host :</strong> $3    |||   <strong>requested</strong> $1 times.\n\n"
    done < $write_file
    printf "</div>"
}
high_5_req_stat


printf "<div class=\"cardn\">"


echo "<h3>Requests taking more than 2 seconds</h3>"
cat $logfile | awk '{if ($8 >= 2) print $8,$1,$NF}'| sort | uniq -c | sort | head -5
echo""

echo "<h3>Requests taking more than 5 seconds</h3>"
cat $logfile | awk '{if ($8 >= 5) print $8,$1,$NF}' | sort | uniq -c | sort | head -5
echo""


echo "<h3>Requests taking more than 10 seconds</h3>"
cat $logfile | awk '{if ($8 >= 10) print $8,$1,$NF}' | sort | uniq -c | sort | head -5 
echo""

printf "</div>"



