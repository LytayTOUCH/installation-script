#!/bin/bash
echo -e "---- Update Server Dependencies Packages ----"
sudo apt-get update

echo -e "---- Install Docker Engine APT----"
sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
UBUNTU-VERSION=`lsb_release -rs`
case "$UBUNTU-VERSION" in
  "12.04")
    sudo sh -c " echo 'deb https://apt.dockerproject.org/repo ubuntu-precise main' > /etc/apt/sources.list.d/docker.list"
  ;;
  "14.04")
    sudo sh -c " echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' > /etc/apt/sources.list.d/docker.list"
  ;;
  "15.10")
    sudo sh -c " echo 'deb https://apt.dockerproject.org/repo ubuntu-wily main' > /etc/apt/sources.list.d/docker.list"
  ;;
esac
echo -e "---- Update Server Dependencies for Docker ----"
sudo apt-get update
echo -e "---- Purge the old repo if it exists ----"
sudo apt-get purge lxc-docker
echo -e "---- Verify that APT ----"
apt-cache policy docker-engine
echo -e "---- Update Server Dependencies for Docker ----"
sudo apt-get update
echo -e "---- Install the recommended package ----"
sudo apt-get install linux-image-extra-$(uname -r)
echo -e "---- Install Docker ----"
sudo apt-get install docker-engine
echo -e "---- Start the docker daemon ----"
sudo service docker start
echo -e "---- Create the docker group and add your user ----"
sudo usermod -aG docker `whoami`
echo -e "---- Done successfully ----"
