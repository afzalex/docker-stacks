#!/bin/bash
# Runner for traefik

source ../run-preprocess.tpl.sh

# Create .data directory if it doesn't exist
mkdir -p ./.data
    
# Check if HOST_WORKDIR contains any non-yml files
if ls "${HOST_WORKDIR}"/* >/dev/null 2>&1 && find "${HOST_WORKDIR}" -type f ! -name "*.yml" -print -quit | grep -q .; then
    TRAEFIK_DYNAMIC_CONFIGS_DIR="./.data/dynamic"
    # Create dynamic directory if it doesn't exist
    mkdir -p "${TRAEFIK_DYNAMIC_CONFIGS_DIR}"
    # Copy dynamic.example.yml to dynamic config directory if it doesn't exist
    if [ ! -f "${TRAEFIK_DYNAMIC_CONFIGS_DIR}/dynamic.yml" ] && ! ls "${TRAEFIK_DYNAMIC_CONFIGS_DIR}"/*.yml >/dev/null 2>&1; then
        cp dynamic.example.yml "${TRAEFIK_DYNAMIC_CONFIGS_DIR}/dynamic.yml"
    fi
else
    TRAEFIK_DYNAMIC_CONFIGS_DIR="${HOST_WORKDIR}"
fi

echo "TRAEFIK_DYNAMIC_CONFIGS_DIR: ${TRAEFIK_DYNAMIC_CONFIGS_DIR}"

# Copy traefik.yml to .data directory if it doesn't exist
if [ ! -f "./.data/traefik.yml" ]; then
    cp traefik.yml ./.data/traefik.yml
fi

# Create certs directory if it doesn't exist
mkdir -p ./.data/certs

docker run --name ${CONTAINER_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --env-file ".env" \
    -p ${PORT_MAPPING}:80 \
    -p ${PORT_MAPPING_SECURE}:443 \
    -p ${PORT_MAPPING_DASHBOARD}:8080 \
    --rm \
    --add-host=host.docker.internal:host-gateway \
    -v ./.data/certs:/etc/traefik/certs \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ./.data/traefik.yml:/etc/traefik/traefik.yml \
    -v "${TRAEFIK_DYNAMIC_CONFIGS_DIR}":/etc/traefik/dynamic \
    ${CONTAINER_NAME}
    



