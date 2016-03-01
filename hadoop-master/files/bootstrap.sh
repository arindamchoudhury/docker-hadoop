#!/usr/bin/env bash

service sshd start
sleep 2

/usr/sbin/ntpd -u ntp:ntp -p /var/run/ntpd.pid -g -n
sleep 2

/usr/local/consul/bin/consul agent -config-dir /usr/local/consul/config --domain=$CONSUL_DOMAIN_NAME -join $CONSUL_SERVER_ADDR
sleep 2

sudo -E -u hdfs /usr/local/hadoop-2.7.2/sbin/hadoop-daemon.sh start namenode
sleep 2

sudo -E -u yarn /usr/local/hadoop-2.7.2/sbin/yarn-daemon.sh start resourcemanager
sleep 2

sudo -E -u yarn /usr/local/hadoop-2.7.2/sbin/yarn-daemon.sh start historyserver
sleep 2