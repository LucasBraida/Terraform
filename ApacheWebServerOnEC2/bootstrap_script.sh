#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
echo "<h1>My Webserver with Terraform</h1>" >> /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd