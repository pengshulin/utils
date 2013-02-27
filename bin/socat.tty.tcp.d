#!/bin/sh -e
# bind tty with tcp port using socat
#

if [ $# != 2 ] ; then
  echo 'Arguments: tty-device-file tcp-port-number'
  echo 'tcp-port-number should be between 9000 and 9999'
  exit
fi

if ! [ -c $1 ] ; then
  echo "$1" should be a tty device file
  exit
fi 

if [ $2 -lt 9000 ] || [ $2 -gt 9999 ] ; then
  echo "$2" should be between 9000 and 9999
  exit
fi

reload_counter=0
cmd="socat $1 TCP-LISTEN:$2"

while [ 1 ]; do
  echo "[$reload_counter]" "$cmd"
  $cmd
  reload_counter=$((reload_counter+1)) 
  sleep 3  # wait for a while
  if ! [ -c $1 ] ; then
     echo "$1" does not exists! 
     exit
  fi 
done

