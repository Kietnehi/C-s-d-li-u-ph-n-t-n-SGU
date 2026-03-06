#!/bin/bash

echo -e "\n=== Start 1-node Hadoop Cluster ===\n"

# Stop and remove any existing container named hadoop-master
sudo docker stop hadoop-master 2>/dev/null
sudo docker rm hadoop-master 2>/dev/null

# Run hadoop-master container
sudo docker run -itd \
    --name hadoop-master \
    --hostname hadoop-master \
    -p 50070:50070 -p 8088:8088 \
    kiwenlau/hadoop:1.0

# Wait a few seconds to make sure container is ready
sleep 3

# Start Hadoop services inside the container
sudo docker exec -it hadoop-master /usr/local/hadoop/sbin/start-dfs.sh
sudo docker exec -it hadoop-master /usr/local/hadoop/sbin/start-yarn.sh

echo -e "\n=== Hadoop 1-node Cluster is running ==="
echo "NameNode: http://localhost:50070"
echo "ResourceManager: http://localhost:8088"
