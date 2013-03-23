#!/bin/bash
# Peng Shulin <trees_peng@163.com>

if ! [ -f zshrc ]; then
    echo 'no zshrc found in current directory'
    exit 1
fi

if [ -f ~/.zshrc ]; then
    zshrc_file=`pwd`/zshrc
    if ! grep "source $zshrc_file" ~/.zshrc >/dev/null ; then
        echo "source $zshrc_file" >> ~/.zshrc
    fi
fi

