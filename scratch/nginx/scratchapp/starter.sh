#!/bin/sh

echo Starting nginx
nginx

echo Starting reloader
sh /var/lib/scratchapp/nginx-reloader-script.sh &

echo Starting to listen error.log file
tail -f /var/log/nginx/error.log