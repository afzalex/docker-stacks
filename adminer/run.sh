#!/bin/bash
# Runner for mysql

source ../run-preprocess.tpl.sh

docker run --name ${IMAGE_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --env-file ".env" \
    --rm \
    -p ${PORT_MAPPING}:8080 \
    ${CONTAINER_NAME}