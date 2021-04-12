#!/bin/sh

if [ -d "/tmp/data" ]; then
    echo "Initial directory found. Moving it to data directory" 
    mv /tmp/data/* /data
    rm /data/initflag
    touch /data/movedflag
fi

exec /usr/bin/entrypoint "$@"
