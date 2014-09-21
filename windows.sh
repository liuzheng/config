#!/bin/bash

if (cat $HOME/.bashrc|grep "liuzheng_bashrc")
then
    echo "Already added"
else
    echo "source $PWD/.liuzheng_bashrc">>$HOME/.bashrc
fi
git submodule init
git submodule update
. ~/.bashrc
cd `pwd`/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.sh --clang-completer
