#!/bin/bash

sed -i -e "s/FLUME_HOST/${FLUME_PORT_9000_TCP_ADDR:=localhost}/" \
       -e "s/IRODS_HOST/${IRODS_PORT_1247_TCP_ADDR:=localhost}/" \
       -e "s/IRODS_PORT/${IRODS_HOST_PORT:=1247}/" \
       -e "s/IRODS_USER/${IRODS_USER:=rods}/" \
       -e "s/IRODS_PASSWORD/${IRODS_PASSWORD:=password}/" \
       -e "s/IRODS_ZONE/${IRODS_ZONE:=tempZone}/" \
       /opt/istats/etc/istats.conf

if [ -n "${DEMO}" ]; then
    sed -i -e "s/\*\/10 \* \* \* \* root \/opt\/istats\/bin\/istats/*\/2 * * * * root \/opt\/istats\/bin\/istats/" /etc/crontab
    echo "* * * * * root /opt/istats/bin/istats_demo 2>&1 > /opt/istats/log/istats_demo.log" >> /etc/crontab
fi

/usr/sbin/cron
tail -f /opt/istats/log/istats.log /opt/istats/log/istats_demo.log
