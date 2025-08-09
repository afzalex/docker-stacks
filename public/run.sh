#!/bin/bash
# Runner for public

source ../run-preprocess.tpl.sh

# Create .data directory if it doesn't exist
mkdir -p ./.data

# Copy index.html to .data/html if it doesn't exist
if [ ! -f ./.data/html/index.html ]; then
    echo "Copying index.html to .data/html..."
    mkdir -p ./.data/html
    cp ./index.html ./.data/html/
fi


# Remove existing container if running
if [[ " $@ " =~ " --force " ]]; then
    echo "Removing existing ${CONTAINER_NAME} container..."
    docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
fi

docker run --name ${CONTAINER_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --env-file ".env" \
    -p ${PORT_MAPPING}:80 \
    $(if [[ " $@ " =~ " --persist " ]]; then echo "--restart unless-stopped -d"; else echo "--rm"; fi) \
    -v ./.data/html:/usr/share/nginx/html \
    ${CONTAINER_NAME}
    



