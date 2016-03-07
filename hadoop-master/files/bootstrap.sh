#!/usr/bin/env bash

source /etc/profile

#service ssh start
#sed -i '/^#export HADOOP_HEAPSIZE=/ s:.*:export HADOOP_HEAPSIZE==500:' /usr/local/hadoop-2.7.2/etc/hadoop/hadoop-env.sh
#sed -i '/^export HADOOP_JOB_HISTORYSERVER_HEAPSIZE/ s:.*:export HADOOP_JOB_HISTORYSERVER_HEAPSIZE=500:' /usr/local/hadoop-2.7.2/etc/hadoop/mapred-env.sh

service ntp start

nohup /usr/local/consul/bin/consul agent -config-dir /usr/local/consul/config --domain=$CONSUL_DOMAIN_NAME -join $CONSUL_SERVER_ADDR >>/var/log/consul.log 2>&1 &

while true
do
  STATUS=$(curl -s -o /dev/null -w '%{http_code}' http://localhost:8500/v1/kv/hadoop/hadoopconfiguration)
  if [ $STATUS -eq 200 ]; then
    break
  fi
  sleep 3
done

curl -X PUT -d $HOSTNAME http://localhost:8500/v1/kv/NAMENODE_ADDR
curl -X PUT -d $HOSTNAME http://localhost:8500/v1/kv/JOBHISTORY_ADDR
curl -X PUT -d $HOSTNAME http://localhost:8500/v1/kv/YARN_RESOURCEMANGER_HOSTNAME

#export putoamo=$(curl -s http://localhost:8500/v1/kv/NAMENODE_ADDR?raw)

consul-template -template "/tmp/core-site.xml.ctmpl:/usr/local/hadoop-2.7.2/etc/hadoop/core-site.xml" -once
consul-template -template "/tmp/hdfs-site.xml.ctmpl:/usr/local/hadoop-2.7.2/etc/hadoop/hdfs-site.xml" -once
consul-template -template "/tmp/mapred-site.xml.ctmpl:/usr/local/hadoop-2.7.2/etc/hadoop/mapred-site.xml" -once
consul-template -template "/tmp/yarn-site.xml.ctmpl:/usr/local/hadoop-2.7.2/etc/hadoop/yarn-site.xml" -once

python /etc/memory_config.py

chgrp -R hadoop $HADOOP_PREFIX
chmod -R g+rwxs $HADOOP_PREFIX

sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs namenode -format

curl -X PUT -d 'formatted' http://localhost:8500/v1/kv/hadoop/namenodeformat

sudo -E -u hdfs /usr/local/hadoop-2.7.2/sbin/hadoop-daemon.sh start namenode

curl -X PUT -d 'started' http://localhost:8500/v1/kv/hadoop/namenode

sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -mkdir -p /user/hdfs
sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -chown hdfs:hadoop /user/hdfs

sudo -E -u yarn /usr/local/hadoop-2.7.2/sbin/yarn-daemon.sh start resourcemanager
curl -X PUT -d 'started' http://localhost:8500/v1/kv/hadoop/resourcemanager

sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -mkdir -p /mr-history/tmp
sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -chmod -R 1777 /mr-history/tmp

sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -mkdir -p /mr-history/done
sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -chmod -R 1777 /mr-history/done
sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -chown -R mapred:hdfs /mr-history

sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -mkdir -p /app-logs
sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -chmod -R 1777 /app-logs

sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -chown yarn:hdfs /app-logs

sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -mkdir -p /tmp/hadoop-yarn
sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfs -chown yarn:hadoop /tmp/hadoop-yarn

sudo -E -u yarn /usr/local/hadoop-2.7.2/sbin/mr-jobhistory-daemon.sh start historyserver
curl -X PUT -d 'started' http://localhost:8500/v1/kv/hadoop/historyserver

curl -X PUT -d 'started' http://localhost:8500/v1/kv/hadoop/finished


if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
