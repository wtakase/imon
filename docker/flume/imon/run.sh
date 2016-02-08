#!/bin/bash

FLUME_HOST=`awk 'NR==1 {print $1}' /etc/hosts`
sed -i -e "s/FLUME_HOST/${FLUME_HOST}/g" \
       -e "s/ELASTICSEARCH_HOST/${ELASTICSEARCH_PORT_9300_TCP_ADDR:=localhost}/g" \
       /opt/flume/conf/flume.conf

/opt/flume/bin/flume-ng agent -c ${FLUME_CONF_DIR:=/opt/flume/conf} \
                              -f ${FLUME_CONF_FILE:=/opt/flume/conf/flume.conf} \
                              -n ${FLUME_AGENT_NAME:=agent} \
                              -Dflume.root.logger=INFO,console
