#!/bin/bash
scp remote/* root@pve1:/tmp && ssh root@pve1 /tmp/postinstall.sh

