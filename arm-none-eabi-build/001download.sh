#!/bin/sh
. ./envset.sh

FILE=binutils-$VER_BINUTILS.tar.bz2
test -f $FILE || ( wget ftp://ftp.gnu.org/gnu/binutils/$FILE && tar jxf $FILE )

FILE=gcc-$VER_GCC.tar.bz2
test -f $FILE || ( wget ftp://ftp.gnu.org/gnu/gcc/gcc-$VER_GCC/$FILE && tar jxf $FILE )

FILE=gcc-core-$VER_GCC.tar.bz2
test -f $FILE || ( wget ftp://ftp.gnu.org/gnu/gcc/gcc-$VER_GCC/$FILE && tar jxf $FILE )

FILE=gcc-g++-$VER_GCC.tar.bz2
test -f $FILE || ( wget ftp://ftp.gnu.org/gnu/gcc/gcc-$VER_GCC/$FILE && tar jxf $FILE )

FILE=gdb-$VER_GDB.tar.bz2
test -f $FILE || ( wget ftp://ftp.gnu.org/gnu/gdb/$FILE && tar jxf $FILE )

FILE=newlib-$VER_NEWLIB.tar.gz
test -f $FILE || ( wget ftp://sourceware.org/pub/newlib/$FILE && tar zxf $FILE )


