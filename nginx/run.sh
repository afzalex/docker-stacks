#!/bin/bash

source prerun.sh

export ENVRIONMENT_PREFIX="FZNGINX"

source ../run-preprocess.sh.tpl

docker run --name ${IMAGE_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --env-file <(env | grep "$ENVRIONMENT_PREFIX") \
    -p 80:80 -p 443:443 --rm -d \
    ${CONTAINER_NAME}