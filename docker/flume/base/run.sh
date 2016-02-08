#!/bin/bash

/opt/flume/bin/flume-ng agent -c ${FLUME_CONF_DIR:=/opt/flume/conf} \
                              -f ${FLUME_CONF_FILE:=/opt/flume/conf/flume.conf} \
                              -n ${FLUME_AGENT_NAME:=agent} \
                              -Dflume.root.logger=INFO,console
