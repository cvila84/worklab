#!/bin/bash
scp ../common/* root@$PVE1_HOST:/tmp && scp remote/* root@$PVE1_HOST:/tmp && ssh root@$PVE1_HOST /tmp/run.sh 9001 $http_proxy
if [[ ! -z "$PVE2_HOST" ]]; then
  scp ../common/* root@$PVE2_HOST:/tmp && scp remote/* root@$PVE2_HOST:/tmp && ssh root@$PVE2_HOST /tmp/run.sh 9002 $http_proxy
fi
