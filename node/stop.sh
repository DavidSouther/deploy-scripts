#!/bin/sh
ROOTDIR="$(cd "$(dirname $0)/../.." && pwd)"

source $ROOTDIR/env/environment.sh

PIDPATH=$ROOTDIR/run/node.pid

[ -f $PIDPATH ] || {
    echo "Node not running." ;
    exit 0 ;
}

kill $(cat $PIDPATH)
rm $PIDPATH

sh $ROOTDIR/deploy/redis/stop.sh
sh $ROOTDIR/deploy/mongo/stop.sh
