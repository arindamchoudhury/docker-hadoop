#!/usr/bin/env bash

source /etc/profile

#service ssh start

service ntp start

nohup /usr/local/consul/bin/consul agent -config-dir /usr/local/consul/config --domain=$CONSUL_DOMAIN_NAME -join $CONSUL_SERVER_ADDR >>/var/log/consul.log 2>&1 &

while true
do
  STATUS=$(curl -s -o /dev/null -w '%{http_code}' http://localhost:8500/v1/kv/hadoop/namenode)
  if [ $STATUS -eq 200 ]; then
    break
  fi
  sleep 3
done

consul-template -template "/tmp/core-site.xml.ctmpl:/usr/local/hadoop-2.7.2/etc/hadoop/core-site.xml" -once
consul-template -template "/tmp/hdfs-site.xml.ctmpl:/usr/local/hadoop-2.7.2/etc/hadoop/hdfs-site.xml" -once
consul-template -template "/tmp/mapred-site.xml.ctmpl:/usr/local/hadoop-2.7.2/etc/hadoop/mapred-site.xml" -once
consul-template -template "/tmp/yarn-site.xml.ctmpl:/usr/local/hadoop-2.7.2/etc/hadoop/yarn-site.xml" -once

python /etc/memory_config.py

chgrp -R hadoop $HADOOP_PREFIX
chmod -R g+rwxs $HADOOP_PREFIX

sudo -E -u hdfs /usr/local/hadoop-2.7.2/sbin/hadoop-daemon.sh start datanode

while true
do
  STATUS=$(curl -s -o /dev/null -w '%{http_code}' http://localhost:8500/v1/kv/hadoop/resourcemanager)
  if [ $STATUS -eq 200 ]; then
    break
  fi
  sleep 3
done

sudo -E -u yarn /usr/local/hadoop-2.7.2/sbin/yarn-daemon.sh start nodemanager

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
