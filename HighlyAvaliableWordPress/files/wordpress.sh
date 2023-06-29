#!/bin/bash

sudo yum update -y
sudo yum upgrade -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz