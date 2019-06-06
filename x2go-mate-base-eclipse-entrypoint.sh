#!/bin/bash
/x2go-mate-base-entrypoint.sh 1
/set_env.sh
/eclipse_conf.sh
/permissions.sh
if [ -z "$1" ]
  then
  sh start-supervisor.sh
fi
