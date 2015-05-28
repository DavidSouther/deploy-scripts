#!/bin/sh
ROOTDIR="$(cd "$(dirname $0)/../.." && pwd)"

source $ROOTDIR/env/environment.sh

sh $ROOTDIR/deploy/redis/stop.sh

rm -rf $ROOTDIR/run/redis_db

echo "Redis dump dropped."
