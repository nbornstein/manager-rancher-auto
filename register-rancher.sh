#!/bin/bash

RANCHER_URL=https://mmrancher3.houseofswartz.net

# Create imported Cluster and get the cluster ID
#TOKEN={token-RancherAPIToken}
TOKEN=token-2v98m:xmppsccz58lrdnh8sfwq75hx67dvbfm6qgdgm8ghmkkcqf5gt82tkd
CLUSTER_ID=$(curl -k $RANCHER_URL/v3/clusters \
  -H "content-type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  --data-binary '{
    "type": "cluster",
    "importedConfig": {
    },
    "name": "slb-k3s"
  }' | jq -r .id)
echo $CLUSTER_ID
  
# Run the kubectl command to register Cluster to Rancher
k3sregister() {
CLUSTER_CONNECT=$(curl -k $RANCHER_URL/v3/clusters/$CLUSTER_ID/clusterregistrationtokens \
  -H "content-type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  | jq -r .data[0].insecureCommand)
#echo $CLUSTER_CONNECT
eval "$CLUSTER_CONNECT"
}

# Register cluster
k3sregister

touch /tmp/rancher-registered