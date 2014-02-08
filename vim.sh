#!/bin/bash
# coding: utf-8
# Copyright (c) 2014
# Gmail:liuzheng712
#

cd /tmp/
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar xjf vim-7.4.tar.bz2
cd vim74
./configure --prefix=/usr/local/vim \
  --enable-multibyte \
  --enable-xim \
  --enable-fontset \
  --with-features=huge \
  --enable-pythoninterp=yes \
  --enable-python3interp=yes \
  --enable-rubyinterp=dynamic \
  --disable-darwin \
  --enable-gui=auto \
  --enable-gtk2-check \
  --enable-gnome-check
#  --enable-multibyte    # Include multibyte editing support
#  --enable-xim          # Include XIM input support
#  --enable-fontset      # Include X fontset output support
#  --with-features=huge  # tiny, small, normal, big or huge
#  --enable-pythoninterp=yes # Include Python interpreter
#  --enable-python3interp=yes # Include Python3 interpreter
#  --enable-rubyinterp=dynamic # Include Ruby interpreter
#  --disable-darwin      # Disable Darwin (Mac OS X) support
#  --enable-gui=auto     # X11 GUI default=aauto OPTS=auto/no/gtk2/gnome2/motif/athena/neXtaw/photon/carbon
#  --enable-gtk2-check   # if auto-select GUI, check for GTK+ 2 default=yes
#  --enable-gnome-check  # if GTK GUI, check for GNOME default=no

make -j `cat /proc/cpuinfo | grep "^processor" | wc -l`
make install

