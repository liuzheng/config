#!/bin/bash


if [ `id -u` -ne 0 ]; then
  echo "It must be executed by root."
  exit 1
fi

echo "PATH=/usr/local/texlive/2012/bin/i386-linux:$PATH; export PATH" >> /etc/bash.bashrc
echo "MANPATH=/usr/local/texlive/2012/texmf/doc/man:$MANPATH; export MANPATH" >> /etc/bash.bashrc
echo "INFOPATH=/usr/local/texlive/2012/texmf/doc/info:$INFOPATH; export INFOPATH" >> /etc/bash.bashrc
echo "MANPATH_MAP     /usr/local/texlive/2012/bin/i386-linux        /usr/local/texlive/2012/texmf/doc/man" >> /etc/manpath.config 

