#!/bin/bash

sudo useradd -m -s /bin/bash ansible
sudo usermod -aG sudo ansible
sudo echo "ansible  ALL=(ALL)  NOPASSWD:ALL"  >> /etc/sudoers
sudo mkdir /home/ansible/.ssh
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNIDvkFJSb5HpKgsBq7iKNwO4Wl31oHyW1i5EJND187wKKYCieSUY0vMdWcnjX5vIgK3wxiRbjg1a4V9/TXGNULFwnoti74tzQyvuq0484QUhiU0lDIcMm/63YFexMI3AYcq2JFfKHIRO+EGjFa2st37uiEsfswiqC+lof/9T+8YfkooEDRpr8GHZ629/UEECOzW2Cw46gE47/wuAUc0bv3c+uEL+WNL6SjMsbXD1wZ2SE/2SA+tlrFfnkzcsG/ruWxtqQyv33HFf6SQUyBtXr1OlvU6y4LZZBUX/HViQOrfi3J8rIJF6fpFAFmSVjPG+KHf8DTHjf27yzxyWOJ7FHPP3fu4pgSdOrSuvajcBWlAa/xLOh/7zykOG6BmHQfWlMBLdqejH/wsgcWss0f9q+ky1xNZ77PZIsOs2biCMvZK44yzNT7o6Zhn0EatpJlNMKXk9jREInduDYCVaKoNk/S/T02+DTmxfI8qUvq53raGcGGIrc/9qIubQ+ODspLV0= ansible@DESKTOP-0UPGS9I" >> /home/ansible/.ssh/authorized_keys
sudo chmod 600 /home/ansible/.ssh/authorized_keys
sudo chown -R ansible.ansible /home/ansible
