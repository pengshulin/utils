#!/bin/sh
. ./envset.sh

mkdir -p gcc-$VER_GCC-build
cd gcc-$VER_GCC-build
../gcc-$VER_GCC/configure $GCC_CONFIG
$MAKE all install
