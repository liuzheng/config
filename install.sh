#!/bin/bash
ln -s `pwd`/.vimrc $HOME/
ln -s `pwd`/.vim $HOME/
ln -s `pwd`/.inputrc $HOME/
ln -s `pwd`/.diary $HOME/

git submodule update --init --recursive --depth 1
if (cat $HOME/.zshrc|grep "liuzheng.zshrc")
then
    echo "Already added"
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "export CONFIG_PATH=$PWD">$HOME/.zshrc
    echo "source $PWD/liuzheng.zshrc">>$HOME/.zshrc
fi
. ~/.zshrc
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install npm wget axel htop
npm install 

