#!/bin/bash


if [ `id -u` -ne 0 ]; then
  echo "It must be executed by root."
  exit 1
fi
TEX_Version=0
for i in `ls /usr/local/texlive|grep 2`;
do
  if [ $TEX_Version -le $i ];then
    TEX_Version=$i
  fi
done
TEX_x=`ls /usr/local/texlive/${TEX_Version}/bin/`
echo "PATH=/usr/local/texlive/${TEX_Version}/bin/${TEX_x}:$PATH; export PATH" >> /etc/bash.bashrc
echo "MANPATH=/usr/local/texlive/${TEX_Version}/texmf/doc/man:$MANPATH; export MANPATH" >> /etc/bash.bashrc
echo "INFOPATH=/usr/local/texlive/${TEX_Version}/texmf/doc/info:$INFOPATH; export INFOPATH" >> /etc/bash.bashrc
echo "MANPATH_MAP     /usr/local/texlive/${TEX_Version}/bin/${TEX_x}        /usr/local/texlive/${TEX_Version}/texmf/doc/man" >> /etc/manpath.config 
