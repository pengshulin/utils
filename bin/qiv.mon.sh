#!/bin/sh
# use qiv to monitor a local image
# use SIGUSR1 signal reload the image when 
# file is modified.  Use inotifywait to monitor the modification.
# designed by Shulin Peng <trees_peng@163.com>

if [ $# != 1 ]; then
    echo "usage: $0 imgfile"
    exit 1
fi

img_orig_full=$1
img_orig_dir=`dirname $img_orig_full`
img_orig_base=`basename $img_orig_full`

img_base="~$img_orig_base"
img_full="$img_orig_dir/$img_base"
img_lock="$img_orig_dir/$img_orig_base.lock"

cp $img_orig_full $img_full
rm -f $img_lock

# find if the img monitor is ready 
find_pid()
{
    pid=`pgrep -f "qiv -e $img_full"`
}

# run qiv as sub process if necessary
find_pid
if [ -z "$pid" ]; then
    qiv -e $img_full &
    sleep 1
    find_pid
    if [ -z "$pid" ]; then
        echo 'ERR'
        exit 1
    fi
fi

echo pid $pid 
while [ 1 ];
do
    inotifywait -e close_write $img_orig_full >&2 2>/dev/null
    echo $pid > $img_lock 
    cp $img_orig_full $img_full
    rm -f $img_lock
    /bin/kill -s SIGUSR1 $pid
done

wait


