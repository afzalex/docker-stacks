FROM openjdk:11
ENV KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181
RUN apt-get update
RUN apt-get install gettext-base
RUN wget "https://dlcdn.apache.org/kafka/3.1.0/kafka_2.13-3.1.0.tgz" -O "/tmp/kafka.tgz"
RUN mkdir -p /usr/local/kafka && tar -xzf "/tmp/kafka.tgz" -C /usr/local/kafka --strip-components=1
COPY "kafka-starter.sh" "/usr/local/bin/kafka-starter.sh"
COPY "config-templates" "/usr/local/kafka/config-templates"
RUN /bin/cat /usr/local/kafka/config-templates/server.properties | /usr/bin/envsubst > /usr/local/kafka/config/server.properties
ENTRYPOINT ["/usr/local/bin/kafka-starter.sh"]

