#!/bin/bash

# Rancher API endpoint
RANCHER_API_ENDPOINT=https://mmrancher3.houseofswartz.net

# Rancher API access key and secret key
RANCHER_ACCESS_KEY=token-thj25
RANCHER_SECRET_KEY=fkcjk5dhskvxk65q5bdwdnv7n8bfbzjz59d7nxb8zsfvn2l9fh8vl7

# Kubernetes cluster name
CLUSTER_NAME=niel

# Create a new cluster in Rancher using the API and get the ID
cluster_id=$(curl -ks \
  "${RANCHER_API_ENDPOINT}/v3/cluster" \
  -H "Authorization: Bearer $RANCHER_ACCESS_KEY:$RANCHER_SECRET_KEY" \
  -H "Content-Type: application/json" \
  -d '{
  "type": "cluster",
  "name": "'"$CLUSTER_NAME"'",
  "importedConfig": {}
}' | jq -r '.id')

echo $cluster_id

# Get the registration token from Rancher using the API
registration_token=$(curl -ks \
  "${RANCHER_API_ENDPOINT}/v3/clusterregistrationtoken" \
  -H "Authorization: Bearer $RANCHER_ACCESS_KEY:$RANCHER_SECRET_KEY" \
  -H "Content-Type: application/json" \
  -d '{
  "type": "clusterRegistrationToken",
  "clusterId": "'"$cluster_id"'"
}' | jq -r '.id')

echo $registration_token

# Get the registration command line from Rancher using the API
registration_command=$(curl -ks \
  "${RANCHER_API_ENDPOINT}/v3/clusterregistrationtokens/$registration_token" \
  -H "Authorization: Bearer $RANCHER_ACCESS_KEY:$RANCHER_SECRET_KEY" \
  | jq -r '.insecureCommand')

# Print the registration command line
echo $registration_command
eval $registration_command

touch /tmp/rancher-registered