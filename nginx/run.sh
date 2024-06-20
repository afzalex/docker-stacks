#!/bin/bash

export ENVRIONMENT_PREFIX="FZNGINX"

source ../run-preprocess.sh.tpl


docker run --name ${IMAGE_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --env-file <(env | grep "$ENVRIONMENT_PREFIX") \
    -p 80:80 -p 443:443 --rm \
    ${CONTAINER_NAME}