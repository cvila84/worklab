#!/bin/bash
export ANSIBLE_HOST_KEY_CHECKING="False"
export ANSIBLE_SSH_ARGS="-F /home/kriss/.ssh/config"
#ansible -i inventory.yaml -m ping all
ansible-playbook -i inventory.yaml -e @vars.yaml playbooks/rke.yaml
