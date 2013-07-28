#!/bin/bash
ln -sf `pwd`/.vimrc $HOME/
ln -sf `pwd`/.vim $HOME/
cp `pwd`/.bashrc $HOME/
cp `pwd`/.bash_profile $HOME/
cp 'pwd'/locale.gen /etc/
locale-gen


if (cat $HOME/.bashrc|grep "source $PWD/.liuzheng_bashrc")
then
    echo "Already added"
else
    echo "source $PWD/.liuzheng_bashrc">>$HOME/.bashrc
fi
git submodule init
git submodule update
. ~/.bashrc
