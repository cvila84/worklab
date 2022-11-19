#!/bin/bash
scp proxmox-postinstall.sh root@pve1:/tmp && ssh root@pve1 /tmp/proxmox-postinstall.sh

