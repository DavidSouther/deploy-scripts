#!/bin/sh
ROOTDIR="$(cd "$(dirname $0)/../.." && pwd)"
source $ROOTDIR/env/environment.sh

LOGPATH="$ROOTDIR/run/mongo.log"
PIDPATH="$ROOTDIR/run/mongo.pid"
DBPATH="$ROOTDIR/run/mongo_db"

[ -f "$PIDPATH" ] && {
    echo "Mongo already running (pid $(cat $PIDPATH))!";
    exit 0;
}

mkdir -p $DBPATH
mongod --fork \
    --config /dev/null \
    --dbpath $DBPATH \
    --logpath $LOGPATH \
    --pidfilepath $PIDPATH \
    --port ${MONGO_PORT:-27017} \
    $MONGO_OPTS

echo "Mongo logfile is at $LOGPATH"

sleep 1
