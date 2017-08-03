#!/bin/bash
#plugin 

first_ip=`/sbin/ifconfig|awk -F\: '/Bcast/{gsub(/ |Bcast/,"");print $2}'|head -1`
agent_ip_resp=($(curl -4 -s "http://ip.7road.net"))
agent_ip="${agent_ip_resp[0]}"
endpoint=`awk -F\" '/hostname/{print $4}'  /usr/local/7roadyw/agent/cfg.json`
[ ${#endpoint} -eq 0 ]&& endpoint=$first_ip
[ ${#first_ip} -eq 0 ]&& first_ip="get_error"
[ ${#agent_ip} -eq 0 ]&& agent_ip="get_error"
ts=`date +%s`

echo "[{\"endpoint\": \"$endpoint\", \"tags\": \"first_ip=$first_ip,agent_ip=$agent_ip\", \"timestamp\": $ts, \"metric\": \"ipaddress\", \"value\": 1, \"counterType\": \"GAUGE\", \"step\": 3600}]"
