#!/bin/bash
set -e

publicEnvironmentSetupFile=$(mktemp)
if [ -f 'public.env' ]; then
    cat 'public.env' | while read line; do echo "export $line"; done > "${publicEnvironmentSetupFile}"
    source "${publicEnvironmentSetupFile}"
 else
     echo '>> public.env not found'
     exit 1
fi

environmentSetupFile=$(mktemp)
if [ -f '.env' ]; then
    cat '.env' | while read line; do echo "export $line"; done > "${environmentSetupFile}"
    source "${environmentSetupFile}"
    rm -f "${environmentSetupFile}"
fi

docker rm -f "${IMAGE_NAME}" || true
docker build -t "${IMAGE_NAME}" .

# Check if the network exists, if not, create it
if ! docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
    echo "Creating network: $NETWORK_NAME"
    docker network create "$NETWORK_NAME"
else
    echo "Network $NETWORK_NAME already exists"
fi

PORT_OPTIONS=""
for port_mapping in $PORT_MAPPINGS; do
  PORT_OPTIONS="$PORT_OPTIONS -p $port_mapping"
done

docker run --name ${IMAGE_NAME} -it \
    --network "${NETWORK_NAME}" \
    --env-file "public.env" \
    --env-file <(env | grep "$ENVRIONMENT_PREFIX") \
    $PORT_OPTIONS --rm \
    ${CONTAINER_NAME} "$@"

