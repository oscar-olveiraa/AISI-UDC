import time
import redis
import subprocess
from flask import Flask
from flask import request
from markupsafe import Markup
from flask import render_template

app = Flask(__name__)
redis_host = 'redis-server'
cache = redis.Redis(host=redis_host, port=6379)
error = None

def get_hit_count():
    global error
    retries = 2
    redis_result = True

    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                error = str(exc)
                return -1
            retries -= 1
            time.sleep(0.5)

def get_ip():
    global server_ip
    sys_cmd = "ip -f inet a show eth0| grep inet| awk '{ print $2}' | cut -d/ -f1"
    process = subprocess.run(sys_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    server_ip = process.stdout.decode('utf-8').replace("\n", "")
    return server_ip

server_ip = get_ip()

@app.route('/')
def index():
    global server_ip
    client_ip = request.remote_addr
    counter = get_hit_count()

    if counter == -1:
        height = '355px'
        result = Markup('<span style="color: red;">FAILED</span><p><span style="color: red;">{}</span>').format(error)
        counter = Markup('<span style="color: red;">N/A</span>')
    else:
        height = '330px'
        result = Markup('<span style="color: green;">PASSED</span>')
        count = counter
        counter = Markup('<span style="color: green;">{}</span>').format(count)

    return render_template('index.html', redis_host=redis_host, counter=counter, result=result, client_ip=client_ip, server_ip=server_ip)
