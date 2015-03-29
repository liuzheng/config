#!/bin/bash

if [ `id -u` -ne 0 ]; then
  echo "It must be executed by root."
  exit 1
fi

# apt-get install
#apt-get install unzip libaio1 python-dev python-pip -y --force-yes
#apt-get install python-setuptools

########## from http://yeasy.gitbooks.io/docker_practice/content/install/ubuntu.html#docker
apt-get install apt-transport-https
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
bash -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
apt-get update
apt-get install lxc-docker -y --force-yes
######### end

cat <<EOF>> /etc/default/docker
DOCKER_OPTS="-H unix:///var/run/docker.sock -H 0.0.0.0:4243 --insecure-registry 127.0.0.1:5000"
EOF
export no_proxy="http://127.0.0.1"
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
update-grub

echo -n "System will reboot?(Y/n)"
read Yn
if [ -z $Yn ]; then
  Yn="y"
fi
if [ "$Yn" == "y" ]; then
  reboot
fi

