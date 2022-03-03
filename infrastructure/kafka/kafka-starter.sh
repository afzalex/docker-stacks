#!/bin/bash

 if [ -z ${KAFKA_ZOOKEEPER_CONNECT} ]; then 
    echo "KAFKA_ZOOKEEPER_CONNECT environment not set"
    exit 1
fi


count=0
while true; do 
    zookeeperConnectionOutput=$(curl -sS "${KAFKA_ZOOKEEPER_CONNECT}" 2>&1); 
    if [ ! "${zookeeperConnectionOutput}" = 'curl: (52) Empty reply from server' ]; then 
        count=$(( $count + 1 ))
        echo -e "\033[31mzookeeper is not available at ... ${count}\033[0m"
        sleep 1
    else 
        echo "zookeeper found at ${KAFKA_ZOOKEEPER_CONNECT}"
        break
    fi
done

/bin/cat /usr/local/kafka/config-templates/server.properties | /usr/bin/envsubst > /usr/local/kafka/config/server.properties

/usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties