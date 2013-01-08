#!/bin/sh
# run st-util gdbserver looply
#

# counts reload times
reload_counter=0

# main loop
while [ 1 ]; do
  echo "Starting st-util..."
  st-util
  echo "st-util stopped"
  echo
  # /bin/sh is aliased to dash, so 'let' is invalid
  #let reload_counter++
  reload_counter=$((reload_counter+1)) 
  echo "Reload for the $reload_counter time"
  # wait for a while
  sleep 3
done

