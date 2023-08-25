#!/bin/bash

docker rm -f "fz-nginx"
docker build -t "fz-nginx" .

environmentSetupFile=$(mktemp)
if [ -f '.env' ]; then 
    cat '.env' | while read line; do echo "export $line"; done > "${environmentSetupFile}"
    source "${environmentSetupFile}"
    rm -f "${environmentSetupFile}"
# else 
#     echo '>> .env not found'
#     exit 1
fi

docker run --name fz-nginx -it --env-file <(env | grep IGUPDR) \
    -v ${PWD}:/videos --rm \
    fz-nginx

