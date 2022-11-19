#!/bin/bash
export ROOT="${PWD}"
export ANSIBLE_HOST_KEY_CHECKING="False"
export ANSIBLE_SSH_ARGS="-F ${ROOT}/ssh.config"
ansible -i inventory.yaml -m ping all
