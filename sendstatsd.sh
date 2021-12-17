#!/bin/bash

# HOSTNAME and PORT are optional arguments
# if not passed in, then an OneAgent on localhost and port 18125 iss assumed 
# Here is an example to pass in the Public IP and port for the ActiveGate 
# ./sendstatsd.sh 111.222.333.444 18126

HOSTNAME=$1
PORT=$2

if [ -z "${HOSTNAME}" ]; then
    HOSTNAME=127.0.0.1
    PORT=18125
fi

# https://github.com/statsd/statsd#usage
# https://www.computerhope.com/unix/nc.htm
# nc command usage
# -u = udp
# -w = time to wait for the connection. AG does not respond so we want to
#      to timeout quickly.  By setting to 1 second we spread out the data
#      to view in Dyantrace
# -v = verbose

for loop in {1..100};
do
  echo "loop #: ${loop}"
  echo "test.statsd.guage:${loop}|g" | nc -v -u -w 1 $HOSTNAME $PORT
  echo "test.statsd.guage:${loop}|g|#dim1:a" | nc -v -u -w 1 $HOSTNAME $PORT
  echo "test.statsd.guage:${loop}|g|#dim1:b" | nc -v -u -w 1 $HOSTNAME $PORT
  echo "test.statsd.counter:${loop}|c" | nc -v -u -w 1 $HOSTNAME $PORT
done