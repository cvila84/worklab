#!/bin/bash
scp remote/* root@pve.home:/tmp && ssh root@pve.home /tmp/run.sh

