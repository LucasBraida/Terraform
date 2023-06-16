#!/bin/bash

sudo useradd -m -s /bin/bash ansible
sudo usermod -aG sudo ansible
sudo echo "ansible  ALL=(ALL)  NOPASSWD:ALL"  >> /etc/sudoers
sudo mkdir /home/ansible/.ssh
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDU9qK+C3T/SoAE2xUrlv65dIpeXLO1HbFR6SzI9Y7iJ2Cv0jSxnYBf9D8ST1Ki+2lBvqwKGSfslU0zNSWr/mArnZ+Pp5kQraC55CfQw6dKjBByY5Y3YRkcrGj5dDb+UWMkIiutnqWGkW3UDn+tVobifL0auJR7k5zUGQEFzs7re/lHTh9IvTWKUhV3QFpneLYgABNDwxycLevofo2JTJFM9XZujyrL9wI2ZkU1QUpxFSqpFI2VbbE7ucROF1b2w5W1KrawZoZZOUeQUIKbfFI/62RsRs1r0hHbMa9V1Yi1kCDe/TAPfRDix8/iZMw+5frqJdGpNQpFvZo8OZYObg1+aWoCerwdElP9BYOahLlEiIDaQFy/ZhuWjRu2//1Cj1MKMXeiSTqGQ8+XdJmoDD8DQYI21i4xJCtOzzp0qbyfWs8PPw0BGXmO+RulMMcNVbMqahbOBHdx8BMD/mzK2Yz6YVMwf0NlwlLKmd7Wd4S7iac8+VItNnhSBLy+Y6Iblr8= ansible@work-PC" >> /home/ansible/.ssh/authorized_keys
sudo chmod 600 /home/ansible/.ssh/authorized_keys
sudo chown -R ansible.ansible /home/ansible
