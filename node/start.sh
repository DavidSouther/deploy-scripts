#!/bin/sh
ROOTDIR="$(cd "$(dirname $0)/../.." && pwd)"
echo "Starting in $ROOTDIR"

source $ROOTDIR/env/environment.sh

# Start persistence
sh $ROOTDIR/deploy/mongo/start.sh
sh $ROOTDIR/deploy/redis/start.sh

# Check that we aren't already started
[ -f $ROOTDIR/run/node.pid ] && {
    echo "Node already running ($(cat $ROOTDIR/run/node.pid))!"
    exit 0;
}

# Rotate old log files
[ -f $ROOTDIR/run/node.log ] && {
    LOG=$ROOTDIR/run/node.log
    TMP=$LOG.$(date +%Y-%m-%dT%H-%M-%S)
    echo "log file [${LOG}] exists; copied to temporary file [${TMP}]"
    mv $LOG $TMP
}

SCRIPT=app

if [ "x$NODE_ENV" == "xdevelopment" ] ; then
  SCRIPT=supervise
fi

node \
  $ROOTDIR/$SCRIPT.js \
  >| $ROOTDIR/run/node.log 2>&1 </dev/null \
  &

PID=$!
[ $? == 0 ] && echo $PID >| $ROOTDIR/run/node.pid

echo "Combined out/err node log at $ROOTDIR/run/node.log"
