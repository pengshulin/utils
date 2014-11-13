#!/bin/sh
# generate version using combination of git branch name and date
# designed by Shulin Peng <trees_peng@163.com>

date=`date`
if [ -z "$1" ]; then
releasebranch=`git branch --list --no-color | grep "*" | cut -b 3-`
releasedate=`date +%y%m%d`
releasename="$releasebranch-$releasedate"
else
releasename="$1"
fi

echo $releasename

