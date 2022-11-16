#!/bin/bash
export INSTANCE_NUMBER=$(docker inspect -f '{{.Name}}' $HOSTNAME | tr -dc '0-9')
export INSTANCE_COUNT=$(yq eval '.instances | keys' /config/instances.yml | wc -l)
export KEY=$(yq '.instances | keys' /config/instances.yml | sed -n "s/- //;${INSTANCE_NUMBER}p")

echo "Smee instance ${INSTANCE_NUMBER} of ${INSTANCE_COUNT} for service ${KEY}"

export SMEE_PROXY_URL=$( yq .instances.${KEY}.smee_url /config/instances.yml)
export SMEE_TARGET_URL=$( yq .instances.${KEY}.target_url /config/instances.yml)
 
smee -u $SMEE_PROXY_URL -t $SMEE_TARGET_URL