#!/bin/bash

docker run \
    --name jupyter \
    --user root \
    -p 7801:8888 -p 7802:5000 -p 7803:8080 \
    -v "${PWD}/.data:/home/" \
    -e JUPYTER_ENABLE_LAB:yes \
    -e GRANT_SUDO:yes \
    -d $@ jupyter/scipy-notebook \
    start-notebook.sh --NotebookApp.token='' --NotebookApp.password=''