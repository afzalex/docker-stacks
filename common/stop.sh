#!/bin/bash

publicEnvironmentSetupFile=$(mktemp)
if [ -f 'public.env' ]; then
    cat 'public.env' | while read line; do
      if [ "${#line}" -gt 0 ] && [[ ! $line =~ ^# ]]; then
        echo "export $line";
      fi
    done > "${publicEnvironmentSetupFile}"
    source "${publicEnvironmentSetupFile}"
else
    echo '>> public.env not found'
    exit 1
fi

environmentSetupFile=$(mktemp)
if [ -f '.env' ]; then
    cat '.env' | while read line; do
        if [ "${#line}" -gt 0 ] && [[ ! $line =~ ^# ]]; then
          echo "export $line";
        fi
    done > "${environmentSetupFile}"
    source "${environmentSetupFile}"
    rm -f "${environmentSetupFile}"
fi
echo ">> Stopping ${CONTAINER_NAME} container..."

# Stop and remove the container if it exists
docker rm -f "${CONTAINER_NAME}"

echo ">> ${CONTAINER_NAME} container stopped" 