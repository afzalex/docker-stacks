#!/bin/bash

source ../run-preprocess.tpl.sh

# Use PORT_MAPPING from environment file, default to 8888 if not set
PORT_MAPPING=${PORT_MAPPING:-8888}
HOST_WORKDIR=${HOST_WORKDIR:-$(pwd)}

# Create directories for persistence if they don't exist
mkdir -p "${HOST_WORKDIR}/.data/opt/conda/envs"
mkdir -p "${HOST_WORKDIR}/.data/opt/conda/pkgs"

echo "HOST_WORKDIR: ${HOST_WORKDIR}"

# Check if environment.yml exists
if [ -f "${HOST_WORKDIR}/environment.yml" ]; then
    # Get environment name from yml file
    ENV_NAME=$(grep "name:" "${HOST_WORKDIR}/environment.yml" | cut -d' ' -f2)
    
    # Check if environment exists
    if ! docker run --rm \
        -v "${HOST_WORKDIR}/.data/opt/conda/envs:/opt/conda/envs" \
        ${IMAGE_NAME} \
        bash -c "conda env list | grep -q '${ENV_NAME}'"; then
        echo "Creating new conda environment: ${ENV_NAME}"
        docker run --rm \
            -v "${HOST_WORKDIR}:/home/jovyan/work" \
            -v "${HOST_WORKDIR}/.data/opt/conda/envs:/opt/conda/envs" \
            -v "${HOST_WORKDIR}/.data/opt/conda/pkgs:/opt/conda/pkgs" \
            ${IMAGE_NAME} \
            bash -c "conda env create -n ${ENV_NAME}"
    else
        echo "Using existing conda environment: ${ENV_NAME}"
    fi
    
    CONDA_CMD="source /opt/conda/etc/profile.d/conda.sh && conda activate ${ENV_NAME} &&"
else
    echo "No environment.yml found, using default environment"
    ENV_NAME="base"
    CONDA_CMD="source /opt/conda/etc/profile.d/conda.sh && conda activate base &&"
fi

docker run --name ${CONTAINER_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --user root \
    -h "$(hostname)" \
    -p "${PORT_MAPPING}:8888" \
    -v "${HOST_WORKDIR}:/home/jovyan/work" \
    -v "${HOST_WORKDIR}/.data/opt/conda/envs:/opt/conda/envs" \
    -v "${HOST_WORKDIR}/.data/opt/conda/pkgs:/opt/conda/pkgs" \
    --rm \
    ${IMAGE_NAME} bash -c "${CONDA_CMD} start-notebook.sh \
        --NotebookApp.token='' \
        --NotebookApp.password='' \
        --NotebookApp.allow_origin='*'"