#!/bin/bash

openssl genrsa 2048 > conf/server.key
openssl req -new -key conf/server.key -subj "${SUBJECT:=/C=XX/ST=XX/L=XX/O=XX/OU=XX/CN=${DOCKER_HOST:=localhost}}" > conf/server.csr
openssl x509 -days 3650 -req -signkey conf/server.key < conf/server.csr > conf/server.crt

sed -i -e "s/^ServerName.*/ServerName ${DOCKER_HOST:=localhost}:443/" conf/extra/httpd-ssl.conf
sed -i -e "s/localhost/${ELASTICSEARCH_PORT_9200_TCP_ADDR:=localhost}/g" conf/extra/elasticsearch.conf
sed -i -e "s/localhost/${KIBANA_PORT_5601_TCP_ADDR:=localhost}/g" conf/extra/kibana.conf
curl -XPOST ${ELASTICSEARCH_PORT_9200_TCP_ADDR:=localhost}:9200/_bulk --data-binary @/tmp/kibana.json
curl -XPOST ${ELASTICSEARCH_PORT_9200_TCP_ADDR:=localhost}:9200/.kibana/_bulk --data-binary @/tmp/dashboard.json
httpd-foreground
