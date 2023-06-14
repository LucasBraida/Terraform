#!/bin/bash

sudo useradd -m -s /bin/bash ansible
sudo usermod -aG sudo ansible
sudo echo "ansible  ALL=(ALL)  NOPASSWD:ALL"  >> /etc/sudoers
sudo mkdir /home/ansible/.ssh
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCfMUIU09Loqrw0oqo0+rBtWJNC+kBM7LB7bbqWJn5Dj6l+anZoPRgERXB8LF68r08zzGd8ipXOCShj6wM7tZRjSIRm1r6jujvXcCP89wJ+3GkvpUes9Mu4rU7OzeqAelTtb1J3Mj1YAx27q5aEB0BUG6szcGUcyUd04rTxs2dJlqA73UmL+LOiugkSlPW/cXd8/w+ikhfFXh9e5FKrlRjek3nbkEMlg1rf2kwQVp1rIkr0CAwZJ4f/eiNi0mX3oSTRIGWrtsN9nqQ+G3mFnVj+Tvhx0sXDEm1X4uwUnapOR2xkJSdAqyPzpOfs4CktK+fOSpSSqyrANJ7IxwP3k/HLZKWjkXPwb0eTCA1ccJ8qUXishpoPCUq2+a3oIs31y1r0n8uiukHANFNNMxNRnU4/UwCn+18KAX5LdLq+KkpV/UGBkcXb9YjVmf9PysaZl++EaWCwi6pe10P1OUl4oa2ldcYJFCAcyc7T8Y5K0pKMMaXnc/ezluB7nZlDFE8/08s= ansible@ansible" >> /home/ansible/.ssh/authorized_keys
sudo chmod 600 /home/ansible/.ssh/authorized_keys
sudo chown -R ansible.ansible /home/ansible
