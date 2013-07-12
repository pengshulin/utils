#!/bin/sh
. ./envset.sh

mkdir -p newlib-build
cd newlib-build
$NEWLIB_SRC/configure $NEWLIB_CONFIG
$MAKE all install
