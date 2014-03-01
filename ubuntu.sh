#!/bin/bash
# coding: utf-8
# Copyright (c) 2014
# Gmail:liuzheng712
#

sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak 
sudo cp sources.list /etc/apt/sources.list 
sudo add-apt-repository ppa:gnome3-team/gnome3
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install vim git tmux htop axel tree gnome-shell gnome-tweak-tool gnome-themes* ubuntu-gnome-desktop cairo-dock  -y
sudo apt-get -y --auto-remove purge unity
sudo apt-get -y --auto-remove purge unity-common
sudo apt-get -y --auto-remove purge unity-lens*
sudo apt-get -y --auto-remove purge unity-services
sudo apt-get -y --auto-remove purge unity-asset-pool
#sudo /usr/lib/lightdm/lightdm-set-defaults -s gnome-shell
