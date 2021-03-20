from flask import Flask, flash, render_template, request, redirect, url_for
import os
from werkzeug.utils import secure_filename
import csv
import subprocess
from datetime import datetime as dt

app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/timestamp', methods=['GET', 'POST'])
def timestamp():
    specified_datetime_record = []
    if request.method == "POST":
        fromdate = request.form['from-date']
        fromtime = request.form['from-time']
        # print(type(fromdate))
        months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'Jun',
                  'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

        # print(fromdate)
        # print(fromtime)

        todate = request.form['to-date']
        totime = request.form['to-time']

        todatetemp = fromdate.split("-")
        fromdatetemp = todate.split("-")

        date1 = "" + todatetemp[2] + "/" + \
            months[int(todatetemp[1])] + "/" + todatetemp[0]
        print(date1, fromtime)

        date2 = "" + fromdatetemp[2] + "/" + \
            months[int(fromdatetemp[1])] + "/" + fromdatetemp[0]

        print(date2, totime)

        specified_datetime_record.append(subprocess.check_output(
            ['bash', '-c', f'. specified_timestamp.sh; specified_timestamp {date1} {fromtime} {date2} {totime}'], text=True))

    return render_template('timestamp.html', record_date=specified_datetime_record)


host_names_list = []


def get_host_names_list():
    with open("/home/flask/final/access.log", "r") as file:
        data = file.readlines()
        for line in data:
            host = line.strip().split(' ')[-1]
            if host not in host_names_list:
                host_names_list.append(host)


@app.route('/hostname', methods=['GET', 'POST'])
def hostname_record():
    host_record = []
    if request.method == 'POST':
        hostname = request.form['hostname']
        get_host_names_list()
        print(hostname)
        print(host_names_list)

        for i in host_names_list:
            host_record.append(subprocess.check_output(
                ['bash', '-c', f'. host_info.sh; get_last_status_code {i}'], text=True))

    return render_template('hostname.html', host_data=host_record)
