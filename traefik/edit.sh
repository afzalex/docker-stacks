#!/bin/bash

# Create .data directory if it doesn't exist
mkdir -p ./.data
    
# Check if HOST_WORKDIR contains any non-yml files
if ls "${HOST_WORKDIR}"/* >/dev/null 2>&1 && find "${HOST_WORKDIR}" -type f ! -name "*.yml" -print -quit | grep -q .; then
    TRAEFIK_DYNAMIC_CONFIGS_DIR="./.data/dynamic"
    # Create dynamic directory if it doesn't exist
    mkdir -p "${TRAEFIK_DYNAMIC_CONFIGS_DIR}"
    # Copy dynamic.example.yml to dynamic config directory if it doesn't exist
    if [ ! -f "${TRAEFIK_DYNAMIC_CONFIGS_DIR}/dynamic.yml" ]; then
        cp dynamic.example.yml "${TRAEFIK_DYNAMIC_CONFIGS_DIR}/dynamic.yml"
    fi
else
    TRAEFIK_DYNAMIC_CONFIGS_DIR="${HOST_WORKDIR}"
fi

# Get first argument and check if file exists
if [ $# -eq 0 ] || [[ ! $1 =~ \.ya?ml$ ]]; then
    echo "Error: Please provide a valid YAML file name as argument"
    exit 1
fi

if [ "$1" = "traefik.yml" ]; then
    TRAEFIK_DYNAMIC_CONFIG_FILE="./.data/traefik.yml"
else
    TRAEFIK_DYNAMIC_CONFIG_FILE="${TRAEFIK_DYNAMIC_CONFIGS_DIR}/$1"
fi

# Create config file if it doesn't exist
if [ ! -f "${TRAEFIK_DYNAMIC_CONFIG_FILE}" ]; then
    cp dynamic.example.yml "${TRAEFIK_DYNAMIC_CONFIG_FILE}"
fi

# Check for available editors in order of preference
if command -v gnome-text-editor >/dev/null 2>&1; then
    gnome-text-editor "${TRAEFIK_DYNAMIC_CONFIG_FILE}"
elif command -v vim >/dev/null 2>&1; then
    vim "${TRAEFIK_DYNAMIC_CONFIG_FILE}"
else
    vi "${TRAEFIK_DYNAMIC_CONFIG_FILE}"
fi
