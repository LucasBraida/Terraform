#!/bin/bash

cd terraform
terraform init
terraform apply -auto-approve
cd ../ansible
ansible-playbook -i ../inventory master.yml
ansible-playbook -i ../inventory worker.yml