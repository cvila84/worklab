#!/bin/bash
#ansible -i inventories/$1 -m ping controllers,masters,workers
ansible-playbook -i inventories/$1 $2.yaml $3
