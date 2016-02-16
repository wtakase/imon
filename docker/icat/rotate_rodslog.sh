#!/bin/sh

LOGDIR=/var/lib/irods/iRODS/server/log
SYMLINK=rodsLog.latest
LATEST=`ls -tr $LOGDIR | egrep 'rodsLog\.[0-9]{4}\.[0-9]{2}\.[0-9]{2}' | tail -1`
CURRENT=`readlink $LOGDIR/$SYMLINK`
if [ "$CURRENT" != "$LATEST" ]; then
    echo "`date +"%Y-%m-%d %H:%M:%S"` $LATEST is the latest rodsLog and set as $SYMLINK"
    ln -sfn $LATEST $LOGDIR/$SYMLINK
else
    echo "`date +"%Y-%m-%d %H:%M:%S"` No rodsLog rotation occured"
fi
