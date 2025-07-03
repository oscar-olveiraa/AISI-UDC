#!/bin/bash

echo -e "deb https://ftp.udc.es/ubuntu jammy main restricted universe
deb https://ftp.udc.es/ubuntu jammy-updates main restricted universe
deb https://ftp.udc.es/ubuntu jammy-security main restricted" | sudo tee /etc/apt/sources.list > /tmp/repo-log

sudo apt-get update
sudo apt-get install -y ca-certificates curl lynx gnupg lsb-release
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo /usr/sbin/usermod -aG docker ${USER}
