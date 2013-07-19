#!/bin/bash
ln -sf `pwd`/.vimrc $HOME/
ln -sf `pwd`/.vim $HOME/

if (cat $HOME/.bashrc|grep "source $PWD/.liuzheng_bashrc")
then
    echo "Already added"
else
    echo "source $PWD/.liuzheng_bashrc">>$HOME/.bashrc
fi
git submodule init
git submodule update
. ~/.bashrc
