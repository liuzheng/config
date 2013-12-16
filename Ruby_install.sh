#!/bin/bash
# coding: utf-8
# Copyright (c) 2013
# Gmail:liuzheng712
#

sudo apt-get update
sudo apt-get install -y wget vim build-essential openssl libreadline6 libreadline6-dev libmysqlclient-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev libcurl4-openssl-dev autoconf automake libtool imagemagick libmagickwand-dev libpcre3-dev nodejs libpq-dev
curl -L https://get.rvm.io | bash -s stable
echo '[[ -s "$HOME/.rvm/scripts/rvm"  ]] && . "$HOME/.rvm/scripts/rvm"' >>~/.bashrc
source ~/.bashrc
sed -i -e 's/ftp\.ruby-lang\.org\/pub\/ruby/ruby\.taobao\.org\/mirrors\/ruby/g' ~/.rvm/config/db
gem sources --remove https://rubygems.org/
gem sources -a http://ruby.taobao.org/
#gem sources -l

rvm pkg install readline openssl
rvm reinstall all --force
rvm install 2.0.0
rvm use 2.0.0 --default

gem install rails


