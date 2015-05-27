#!/bin/sh
ROOTDIR="$(cd "$(dirname $0)/../.." && pwd)"
source $ROOTDIR/env/environment.sh

LOGPATH="$ROOTDIR/run/redis.log"
PIDPATH="$ROOTDIR/run/redis.pid"
DBPATH="$ROOTDIR/run/redis_db"

# Check that we aren't already started
PID=$ROOTDIR/run/redis.pid
[ -f $PIDPATH ] && {
    echo "Redis already running (pid $(cat $PIDPATH))!"
    exit 0;
}

# # Rotate old log files
# [ -f $LOGPATH ] && {
#     TMP=$LOGPATH.$(date +%Y-%m-%dT%H-%M-%S)
#     echo "log file [${LOGPATH}] exists; copied to temporary file [${LOGPATH}]"
#     mv $LOGPATH $TMP
# }

[ -d $ROOTDIR/run/redis ] || mkdir $ROOTDIR/run/redis_db

mkdir -p $DBPATH
redis-server \
  --port ${REDIS_PORT:=6379} \
  --daemonize yes \
  --pidfile $PIDPATH \
  --logfile $LOGPATH \
  --dir $DBPATH

#
# PID=$!
# [ $? == 0 ] && echo $PID >| $ROOTDIR/run/redis.pid

echo "Combined out/err redis log at $LOGPATH"
