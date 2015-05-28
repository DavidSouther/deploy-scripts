#!/bin/sh
ROOTDIR="$(cd "$(dirname $0)/../.." && pwd)"
source $ROOTDIR/env/environment.sh

PIDPATH="$ROOTDIR/run/redis.pid"

[ -f $PIDPATH ] || {
    echo "Redis not running." ;
    exit 0 ;
}

# Force the current state of the database
redis-cli save

kill $(cat $PIDPATH)
rm $PIDPATH
