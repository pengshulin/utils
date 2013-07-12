#!/bin/sh

for i in *-build ; do
  echo "Cleanning " $i
  rm -rf $i/*
done

