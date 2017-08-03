#!/bin/bash                                                                                                                                                                                              
#plugin 

first_ip=`/sbin/ifconfig|awk -F\: '/Bcast/{gsub(/ |Bcast/,"");print $2}'|head -1`
endpoint=`awk -F\" '/hostname/{print $4}'  /usr/local/7roadyw/agent/cfg.json`
[ ${#endpoint} -eq 0 ]&& endpoint=$first_ip
ts=`date +%s`


echo "[{\"endpoint\": \"$endpoint\", \"tags\": \"\", \"timestamp\": $ts, \"metric\": \"agent.version\", \"value\": 3, \"counterType\": \"GAUGE\", \"step\": 300}]"
