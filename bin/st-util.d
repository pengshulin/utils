#!/bin/sh
# run st-util gdbserver looply
#

# counts reload times
reload_counter=0
cmd=st-util

# main loop
while [ 1 ]; do
  echo "[$reload_counter]" "$cmd"
  $cmd
  echo
  reload_counter=$((reload_counter+1)) 
  sleep 3  # wait for a while
done

