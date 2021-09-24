#!/bin/bash
ln -s `pwd`/.vimrc $HOME/
ln -s `pwd`/.vim $HOME/
ln -s `pwd`/.inputrc $HOME/

git submodule update --init --depth 1
if (cat $HOME/.zshrc|grep "liuzheng_zshrc")
then
    echo "Already added"
else
    echo "source $PWD/liuzheng_zshrc">$HOME/.zshrc
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
. ~/.zshrc
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install npm wget axel htop
npm install 

