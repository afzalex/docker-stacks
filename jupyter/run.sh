#!/bin/bash

source ../run-preprocess.sh.tpl

docker run --name ${CONTAINER_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --user root \
    -h "$(hostname)" \
    -v "${PWD}/.data:/home/" \
    --rm \
    ${IMAGE_NAME} start-notebook.sh --NotebookApp.token='' --NotebookApp.password='' --ServerApp.base_url='/jupyter' --NotebookApp.allow_origin='*'