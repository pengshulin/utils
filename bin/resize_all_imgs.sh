#!/bin/sh
# resize all images in current directory
# designed by PengShulin <trees_peng@163.com>

if [ $# != 1 ]; then
    echo "Usage: $0 percentage"
    exit 1
fi

ratio="$1%"
files=`ls *.png *.jpg *.bmp 2>/dev/null`
orig_folder='.resize_orig'

if [ -n "$files" ]; then
    mkdir -p $orig_folder
fi

for f in ${files}; do
    echo 'Resizing' $f
    cp $f $orig_folder/$f
    convert -resize $ratio $f $f
done
