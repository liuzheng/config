#!/bin/bash
ln -sf `pwd`/.vimrc $HOME/
ln -sf `pwd`/.vim $HOME/
echo "source $PWD/.liuzheng_bashrc">>$HOME/.bashrc
`source $HOME/.bashrc`
