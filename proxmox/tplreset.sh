#!/bin/bash
scp remote/* root@$PVE_HOST:/tmp && ssh root@$PVE_HOST /tmp/run.sh $PVE_PROXY

