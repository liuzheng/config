#!/bin/bash
ln -s `pwd`/.vimrc $HOME/
ln -s `pwd`/.vim $HOME/
ln -s `pwd`/.bashrc $HOME/
ln -s `pwd`/.bash_profile $HOME/
sudo cp `pwd`/locale.gen /etc/
sudo locale-gen


#if (cat $HOME/.bashrc|grep "source $PWD/.liuzheng_bashrc")
#then
#    echo "Already added"
#else
#    echo "source $PWD/.liuzheng_bashrc">>$HOME/.bashrc
#fi
git submodule init
git submodule update
. ~/.bashrc
