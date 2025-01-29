#!/bin/bash
# Runner for postgresql

source ../run-preprocess.sh.tpl


docker run --name ${IMAGE_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --env-file ".env" \
    -p ${PORT_MAPPING}:5432 --rm \
    -v ./.data/var/lib/postgresql/data:/var/lib/postgresql/data \
    ${CONTAINER_NAME}

