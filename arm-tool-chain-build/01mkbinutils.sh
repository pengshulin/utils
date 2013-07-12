#!/bin/sh
. ./envset.sh

mkdir -p binutils-$VER_BINUTILS-build
cd binutils-$VER_BINUTILS-build
../binutils-$VER_BINUTILS/configure $BINUTILS_CONFIG
$MAKE all install
