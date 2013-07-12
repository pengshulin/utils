export VER_BINUTILS=2.19.1
export VER_NEWLIB=1.17.0
#export VER_NEWLIB=2.0.0
export VER_GCC=4.4.0
#export VER_GDB=6.8
export VER_GDB=7.6

export TARGET=arm-none-eabi
export TARGET_DIR="/opt/$TARGET"
export NEWLIB_SRC="/opt/newlib-$VER_NEWLIB"

export BASE_CONFIG="-v --quiet --target=$TARGET --prefix=$TARGET_DIR --enable-interwork --enable-multilib --with-gnu-ld --with-gnu-as --disable-nls --disable-werror"

export BINUTILS_CONFIG="$BASE_CONFIG"

export BASE_GCC_CONFIG="-v --quiet --target=$TARGET --prefix=$TARGET_DIR --with-gnu-ld --with-gnu-as --disable-shared --disable-nls --disable-werror"

export BOOTGCC_CONFIG="$BASE_GCC_CONFIG --enable-languages=c --without-headers"

export GCC_CONFIG="$BASE_GCC_CONFIG --enable-languages=c,c++ --with-headers=$NEWLIB_SRC/newlib/libc/include --with-newlib --enable-interwork --enable-multilib --with-dwarf2"

export NEWLIB_CONFIG="$BASE_CONFIG"

export GDB_CONFIG="$BASE_CONFIG --with-python"

export PATH="$TARGET_DIR/bin:$PATH"

#FreeBSD should set to gmake(gnu make) rather than make 
export MAKE=make

