#!/bin/sh
ROOTDIR="$(cd "$(dirname $0)/../../.." && pwd)"

source $ROOTDIR/env/environment.sh

sh $ROOTDIR/build/deploy/mongo/stop.sh

rm -rf $ROOTDIR/run/db

echo "Mongo DB dropped."
