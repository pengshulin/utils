#!/bin/sh
# use inkview to monitor a svg file
# open the file twice as a slide list, use xdotool to send 
# Home/End key as Next Prev command to reload the image when 
# file is modified.  Use inotifywait to monitor the modification.
# designed by Shulin Peng <trees_peng@163.com>

if [ $# != 1 ]; then
    echo "usage: $0 svgfile"
    exit 1
fi

svg_full=$1
svg_base=`basename $1`

# find if the svg monitor is ready 
find_winid()
{
    temp=`mktemp`
    xdotool search --onlyvisible --name $svg_base > $temp
    xdotool search --onlyvisible --class inkview >> $temp
    id=`cat $temp | sort | uniq -d`
    rm $temp
}

# run inkview as sub process if necessary
find_winid
if [ -z "$id" ]; then
    inkview $svg_full $svg_full &
    sleep 1
    find_winid
    if [ -z "$id" ]; then
        exit 1
    fi
fi

kill_inkview()
{
    xdotool search --onlyvisible --name $svg_base key q
}

#trap kill_inkview INT

echo $id
while inotifywait -e close_write $svg_full; do
    xdotool key --window $id Down Down Up Up
done

wait


