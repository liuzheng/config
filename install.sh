#!/bin/bash
ln -s `pwd`/.vimrc $HOME/
ln -s `pwd`/.vim $HOME/
sudo cp `pwd`/locale.gen /etc/
sudo locale-gen
mkdir ~/.diary

if (cat $HOME/.bashrc|grep "liuzheng_bashrc")
then
    echo "Already added"
else
    echo "source $PWD/.liuzheng_bashrc">>$HOME/.bashrc
fi
git submodule init
git submodule update
. ~/.bashrc
sudo apt-get install ctags tmux
cd `pwd`/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.sh --clang-completer
