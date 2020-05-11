#!/bin/bash
ln -s `pwd`/.vimrc $HOME/
ln -s `pwd`/.vim $HOME/
ln -s `pwd`/.inputrc $HOME/

mkdir ~/.diary

git submodule update --init --depth 1
if (cat $HOME/.zshrc|grep "liuzheng_zshrc")
then
    echo "Already added"
else
    echo "" >> $HOME/.bashrc
    echo "source $PWD/.liuzheng_zshrc">>$HOME/.zshrc
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
. ~/.zshrc
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install npm 
npm install -g commitizen

