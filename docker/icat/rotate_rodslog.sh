#!/bin/sh

LOGDIR=/var/lib/irods/iRODS/server/log
SYMLINK=rodsLog.latest
LATEST=`ls -tr $LOGDIR | egrep 'rodsLog\.[0-9]{4}\.[0-9]{2}\.[0-9]{2}' | tail -1`
CURRENT=`readlink $LOGDIR/$SYMLINK`
if [ "$CURRENT" != "$LATEST" ]; then
    ln -sfn $LATEST $LOGDIR/$SYMLINK
fi
