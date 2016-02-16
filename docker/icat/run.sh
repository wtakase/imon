#!/bin/bash

/usr/sbin/cron

sed -i -e "s/FLUME_HOST/${FLUME_PORT_10000_TCP_ADDR:=127.0.0.1}/" \
       /opt/flume/conf/flume.conf

nohup /opt/flume/bin/flume-ng agent -c ${FLUME_CONF_DIR:=/opt/flume/conf} \
                                    -f ${FLUME_CONF_FILE:=/opt/flume/conf/flume.conf} \
                                    -n ${FLUME_AGENT_NAME:=agent} \
                                    -Dflume.root.logger=INFO,console &
