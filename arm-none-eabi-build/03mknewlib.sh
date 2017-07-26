#!/bin/sh
. ./envset.sh

mkdir -p newlib-$VER_NEWLIB-build
cd newlib-$VER_NEWLIB-build
$NEWLIB_SRC/configure $NEWLIB_CONFIG
$MAKE all 
#MAKE install
