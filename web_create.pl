#!/usr/bin/perl -w
use List::MoreUtils qw(uniq);


print "<html>\n";
print "<head>\n";
print "<title>Parsed Nginx Data</title>\n";
print "<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css\">\n";
print "<link rel=\"stylesheet\" href=\"{{ url_for('static', filename='css/main.css') }}\">\n";
#print "<link rel=\"stylesheet\" href=\"style.css\">\n";
print "<link rel=\"preconnect\" href=\"https://fonts.gstatic.com\">\n";
print "<link href=\"https://fonts.googleapis.com/css2?family=Poppins&display=swap\" rel=\"stylesheet\">\n";
print "<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js\"></script>\n";
print "<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js\"></script>\n";
print "</head>\n";
print "<body>\n";
print "<div class=\"header\">\n";
print "<h1>NGINX log parser 📜</h1>\n";
@datearray=();
$LOGFILE = '/home/flask/final/access.log';
open(LOGFILE) or die("Could not open log file.");
foreach $line (<LOGFILE>) {
    
    ($ip, $date) = split(' ',$line);
    $time = substr($date, 12);
    $date = substr($date, 0, 11);
    push(@datearray, $date);

    # print "<button type=\"button\" data-toggle=\"collapse\" data-target=\"#demo\">$date</button>";
    # do line-by-line processing.
}
close(LOGFILE);

print "</br>\n";


print "<div>\n";
print "<a href=timestamp><button class=\"btn btn-primary\">Select timestamp</button></a>\n";
print "</div>\n";

print "<div>\n";
print "<a href=hostname><button class=\"btn btn-primary\">Search by host name</button></a>\n";
print "</div>\n";


print "</div>";

print "<div style=\"margin-top: 40px;\">";


@uniqdate=uniq @datearray;
for(my $i = 0; $i <= $#uniqdate; $i++){
	# print("$uniqdate[$i] \n");
    print "<button type=\"button\" class=\"btn btn-success\" data-toggle=\"collapse\" data-target=\"#$i\">$uniqdate[$i]</button>\n\n";

    
    # $returnans = system 'bash', '-c', 'source test.sh; highest_requested $uniqdate[$i]';
    $data = `source collapse_buttons.sh; highest_requested $uniqdate[$i]`;
    # my @ret urce collapse_buttons.sh; highest_requested $uniqdate[$i]`;
    # my @ret = qx(/bin/bash -c "source test.sh; highest_requested $uniqdate[$i]");

    print "<p id=\"$i\" class=\"collapse\">$data</p>\n\n";
     

    # system('/bin/bash', '-c', 'source test.sh; highest_requested $uniqdate[$i] ') ; 
}

print "</div>";



# print "{% extends \"index.html\" %}\n";
# print "{% block content %}\n";
# print "<div class=\"alert alert-info alert-dismissible fade show\" role=\"alert\">\n";
# print "<span><strong>NOTE: I tried to format the below output in a better way.</strong></span>\n";
# print "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n";
# print "<span aria-hidden=\"true\">&times;</span>\n";
# print "</button>\n";            
# print "</div>\n";          
# print "{% if record_date|length >= 1 %}\n";
# print "<div class=\"row\">\n";
# print "<div class=\"col\">\n";    
# print "<div class=\"card card-body\">\n";    
# print "{% for i in record_date %}\n";        
# print "{{i}}\n";          
# print "{% endfor %}\n";
# print "</div>\n";
# print "</div>\n";
# print "</div>\n";
# print "{% else %}\n";
# print "<p> Sorry no record found </p>\n";
# print "{% endif %}\n";
# print "{% endblock %}\n";


# print "From:\n";
# print "<input type=\"date\" value=\"2021-10-03\">\n";
# print "<input type=\"time\" id=\"timepicker\" name=\"timepicker\" value=\"12:30\">\n";
# print "To:\n";
# print "<input type=\"date\" value=\"2021-11-03\">\n";
# print "<input type=\"time\" id=\"timepicker2\" name=\"timmepicker2\" value=\"13:30\">\n";
#print "<button class=\"btn btn-primary\">Select timestamp<a href=timestamp></button>\n";


my $bash_script = '/home/flask/final/next.sh';
open(my $pipe,'-|', $bash_script) or die $!;
while (my $line = <$pipe>){
    print "<p>$line</p>\n";
        # print "<p id=\"$i\" class=\"collapse\"> $line </p>\n";
}

# print "<script>";
# print "document.addEventListener(\"DOMContentLoaded\",function(event) {";
# print "for(var i = 0; i <= 3; i++) {";
# print "var ptag = document.getElementById(\"\" + i).innerHTML;";
# print "var ptextarray = ptag.split(\". \");";
# print "var finalptext = \"\";";
# print "ptextarray.map((j) => {";
# print "finalptext = finalptext + j + \"<br><br>\";";
# print "});";
# print "document.getElementById(\"\" + i).innerHTML = finalptext;";
# print "}";
# print "});";
# print "</script>";

print "<script>";
print "document.addEventListener(\"DOMContentLoaded\", function(event) {";
print "for(var i = 0; i <= 3; i++) {";
print "var ptag = document.getElementById(\"\" + i).innerHTML;";
print "var ptextarray = ptag.split(\". \");";
print "var outputstr = \"\";";
print "for(var j = 0; j < ptextarray.length; j++) {";
print "if(j === 0) {";
print "var headerText = ptextarray[j].split(\": \");";
print "outputstr += \"<h3>\" + headerText[0] + \":</h3><br>\" + headerText[1] + \"<br><br>\";";
print "}";
print "else {";
print "outputstr = outputstr + ptextarray[j] + \"<br><br>\";";
print "}";
print "}";
print "document.getElementById(\"\" + i).innerHTML = outputstr;";
print "}";
print "});";
print "</script>";


print "</body>\n";
print "</html>";
