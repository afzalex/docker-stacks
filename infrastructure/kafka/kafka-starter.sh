#!/bin/bash

 if [ -z ${KAFKA_CFG_ZOOKEEPER_CONNECT} ]; then 
    echo "KAFKA_CFG_ZOOKEEPER_CONNECT environment not set"
    exit 1
fi


count=0
while true; do 
    zookeeperConnectionOutput=$(curl -sS "${KAFKA_CFG_ZOOKEEPER_CONNECT}" 2>&1); 
    if [ ! "${zookeeperConnectionOutput}" = 'curl: (52) Empty reply from server' ]; then 
        count=$(( $count + 1 ))
        echo -e "\033[31mzookeeper is not available at ... ${count}\033[0m"
        sleep 1
    else 
        echo "zookeeper found at ${KAFKA_CFG_ZOOKEEPER_CONNECT}"
        break
    fi
done


/kafka/bin/kafka-server-start.sh /kafka/config/server.properties