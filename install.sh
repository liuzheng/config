#!/bin/bash
ln -s `pwd`/.vimrc $HOME/
ln -s `pwd`/.vim $HOME/
ln -s `pwd`/.inputrc $HOME/

sudo cp `pwd`/locale.gen /etc/
sudo locale-gen
mkdir ~/.diary

if (cat $HOME/.bashrc|grep "liuzheng_bashrc")
then
    echo "Already added"
else
    echo "" >> $HOME/.bashrc
    echo "source $PWD/.liuzheng_bashrc">>$HOME/.bashrc
fi
git submodule update --init #--depth 1
. ~/.bashrc
sudo apt-get install ctags tmux cmake libpython-dev build-essential
#cd `pwd`/.vim/bundle/YouCompleteMe
#git submodule update --init --recursive #--depth 1
#./install.sh --clang-completer
