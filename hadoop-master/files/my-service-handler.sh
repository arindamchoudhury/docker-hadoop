#!/usr/bin/env bash
consul-template -config /usr/local/consul-watch/template.cfg -once

cp /usr/local/consul-watch/result /usr/local/hadoop-2.7.2/etc/hadoop/yarn.include
cp /usr/local/consul-watch/result /usr/local/hadoop-2.7.2/etc/hadoop/dfs.include
cp /usr/local/consul-watch/result /usr/local/hadoop-2.7.2/etc/hadoop/slaves

sudo -u yarn /usr/local/hadoop-2.7.2/bin/yarn rmadmin -refreshNodes

sudo -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs dfsadmin -refreshNodes