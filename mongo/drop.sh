#!/bin/sh
ROOTDIR="$(cd "$(dirname $0)/../.." && pwd)"

source $ROOTDIR/env/environment.sh

sh $ROOTDIR/deploy/mongo/stop.sh

rm -rf $ROOTDIR/run/db

echo "Mongo DB dropped."
