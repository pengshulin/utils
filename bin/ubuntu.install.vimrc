#!/bin/bash
# Peng Shulin <trees_peng@163.com>

if ! [ -f vimrc ]; then
    echo 'no vimrc found in current directory'
    exit 1
fi

if [ -L ~/.vimrc ]; then
    # if it's already a symbolic link, delete it
    rm ~/.vimrc
elif [ -f ~/.vimrc ]; then
    # backup the original
    echo '~/.vimrc -> ~/.vimrc.orig'
    rm ~/.vimrc.orig
    cat ~/.vimrc > ~/.vimrc.orig
    rm ~/.vimrc
fi

ln -s `pwd`/vimrc ~/.vimrc
