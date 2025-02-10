#!/bin/bash
# Runner for traefik

source ../run-preprocess.tpl.sh

# Create .data directories if they don't exist
mkdir -p ./.data/srv
mkdir -p ./.data/database

# Remove existing container if running
if [[ " $@ " =~ " --force " ]]; then
    echo "Removing existing ${CONTAINER_NAME} container..."
    docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
fi

# Check if a directory was provided and if it exists
if [ ! -z "$1" ] && [ ! -d "$1" ]; then
    echo "Error: Directory '$1' does not exist"
    exit 1
fi

# Get the srv directory path - default to .data/srv if not specified
SRV_DIR=$(realpath ${1:-./.data/srv})

# Use exec to ensure signals are properly passed to docker
exec docker run --name ${CONTAINER_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --env-file ".env" \
    $(if [[ " $@ " =~ " --persist " ]]; then echo "--restart unless-stopped -d"; else echo "--rm"; fi) \
    --add-host=host.docker.internal:host-gateway \
    $(if [ ! -z "${PORT_MAPPING}" ]; then echo "-p ${PORT_MAPPING}:80"; fi) \
    -v "${SRV_DIR}":/srv \
    -v ./.data/database:/database \
    -v ./.data/.filebrowser.json:/.filebrowser.json \
    -e FB_BASEURL="/browser" \
    ${CONTAINER_NAME} 
    



