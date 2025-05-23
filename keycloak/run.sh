#!/bin/bash

export ENVRIONMENT_PREFIX="FZKEYCLOAK"

source ../run-preprocess.tpl.sh


docker run --name ${IMAGE_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --env-file ".env" \
    -v ./.data/:/opt/keycloak/data \
    -p ${PORT_MAPPING}:8080 --rm -d \
    ${CONTAINER_NAME} start-dev --proxy-headers forwarded --http-relative-path=/auth --hostname="https://fzmacair.local/auth"