#!/bin/bash

sudo useradd -m -s /bin/bash ansible
sudo usermod -aG sudo ansible
sudo echo "ansible  ALL=(ALL)  NOPASSWD:ALL"  >> /etc/sudoers
sudo mkdir /home/ansible/.ssh
sudo echo "