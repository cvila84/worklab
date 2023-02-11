#!/bin/bash
scp remote/* root@$PVE1_HOST:/tmp && ssh root@$PVE1_HOST /tmp/run.sh $http_proxy
if [[ ! -z "$PVE2_HOST" ]]; then
  scp remote/* root@$PVE2_HOST:/tmp && ssh root@$PVE2_HOST /tmp/run.sh $http_proxy
fi
