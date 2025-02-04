#!/bin/bash
# Runner for traefik

source ../run-preprocess.tpl.sh

# Create .data directory if it doesn't exist
mkdir -p ./.data
    
# Remove existing container if running
if [[ " $@ " =~ " --force " ]]; then
    echo "Removing existing ${CONTAINER_NAME} container..."
    docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
fi

# Check if NVIDIA GPU is supported
if command -v nvidia-smi &> /dev/null; then
    echo "NVIDIA GPU detected, enabling GPU support..."
    DOCKER_GPU_FLAGS="--gpus all"
else
    echo "No NVIDIA GPU detected, running without GPU support"
    DOCKER_GPU_FLAGS=""
fi


echo  docker run --name ${CONTAINER_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --env-file ".env" \
    $(if [[ " $@ " =~ " --persist " ]]; then echo "-d"; else echo "--rm"; fi) \
    -p ${PORT_MAPPING}:8080 ${DOCKER_GPU_FLAGS} \
    -v ./.data/open-webui:/app/backend/data \
    ${CONTAINER_NAME} \

docker run --name ${CONTAINER_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --env-file ".env" \
    $(if [[ " $@ " =~ " --persist " ]]; then echo "-d"; else echo "--rm"; fi) \
    --add-host=host.docker.internal:host-gateway \
    -p ${PORT_MAPPING}:8080 ${DOCKER_GPU_FLAGS} \
    -v ./.data/open-webui:/app/backend/data \
    ${CONTAINER_NAME} \
    



