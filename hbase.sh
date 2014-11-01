#!/bin/bash
# coding: utf-8
# Copyright (c) 2014
# Gmail:liuzheng712
#

if [ `id -u` -ne 0  ]; then
  echo "It must be executed by root."
  exit 1
fi

cd /opt/
curl -O tweibo.gettongji.info/hbase-0.94.19.tar.gz
tar xzf hbase-*.tar.gz
if [ -z $JAVA_HOME ];then
  curl -O tweibo.gettongji.info/jdk-7u55-linux-i586.tar.gz
  tar xzf jdk-*.tar.gz
  if [ -d java ];then
    rm java
  fi

  ln -s jdk1* java
  cat >> /etc/profile << EOF
JAVA_HOME=/opt/java
CLASSPATH=.:$JAVA_HOME/lib.tools.jar
PATH=$JAVA_HOME/bin:$PATH
export JAVA_HOME CLASSPATH PATH
EOF
  . /etc/profile
fi

