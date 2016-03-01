#!/usr/bin/env bash

service ssh start
sleep 2

/usr/sbin/ntpd -u ntp:ntp -p /var/run/ntpd.pid -g -n
sleep 2

nohup /usr/local/consul/bin/consul agent -config-dir /usr/local/consul/config --domain=$CONSUL_DOMAIN_NAME -join $CONSUL_SERVER_ADDR >>/var/log/consul.log 2>&1 &
sleep 2

sudo -E -u hdfs /usr/local/hadoop-2.7.2/sbin/hadoop-daemon.sh start datanode
sleep 2

sudo -E -u yarn /usr/local/hadoop-2.7.2/sbin/yarn-daemon.sh start nodemanager
sleep 2


if [[ $1 == "-d" ]]; then
  while true; do sleep 10; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi