#!/bin/sh

FILE="/root/default.conf"
#COPYLOC="/etc/nginx/http.d/default.conf"
COPYLOC="/etc/nginx/conf.d/default.conf"

cp -f $FILE $COPYLOC
LT=`stat -c %Z $FILE`; 
while true
do 
    AT=`stat -c %Z $FILE`
    if [[ "$AT"  != "$LT" ]]; then 
        cp -f $FILE $COPYLOC
        sleep 1
        nginx -s reload
        LT=$AT
        echo `date "+%Y/%m/%d %H:%m:%S"` [reloader] Default config file reloaded
    fi
    sleep 1
done