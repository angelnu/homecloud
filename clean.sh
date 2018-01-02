#!/bin/bash
PREFIX="kubectl exec -ti glusterfs-storage-g7bv7 --"
GLUSTER_BRICK_PATH=/bricks
GLUSTER_VOLUMES="casa ccu2 iobroker docker-registry"

PEERS=`$PREFIX gluster peer status | grep "Hostname: " | awk -F: '{print $2}'`
for PEER in $PEERS; do
  echo "Process peer $PEER"

  # Check if peer container is already part of the cluster
  PEER_STATUS=`$PREFIX gluster peer status | grep -A2 "Hostname: ${PEER}$" | grep State: | awk -F: '{print $2}'`

  if echo "${PEER_STATUS}" | grep "Disconnected"; then
    for volume in $GLUSTER_VOLUMES; do
      echo " - volume: $volume"

      PEER_INFO=`$PREFIX gluster volume info ${volume}`
      echo "$PEER_INFO"
    	# Check how many peers are already joined in the cluster - needed to add a replica
    	NUMBER_OF_REPLICAS=`echo "${PEER_INFO}"| grep "Number of Bricks:" | awk '{print $6}'`
echo "number of replicas: $NUMBER_OF_REPLICAS"

      #if echo "${PEER_INFO}"| grep ${PEER}; then
        echo "=> Peer container ${PEER} was part of this cluster but must be dropped now ..."
        ${PREFIX} gluster --mode=script volume remove-brick ${volume} replica $((NUMBER_OF_REPLICAS-1)) ${PEER}:${GLUSTER_BRICK_PATH}/${volume} force
        
      #fi

    done

    echo "Removing peer"
    ${PREFIX} gluster peer detach ${PEER} force
  fi
done
