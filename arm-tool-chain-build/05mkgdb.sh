#!/bin/sh
. ./envset.sh

mkdir -p gdb-$VER_GDB-build
cd gdb-$VER_GDB-build
../gdb-$VER_GDB/configure $GDB_CONFIG 
$MAKE all install
