#!/usr/bin/env bash
consul-template -config /usr/local/consul-watch/template.cfg -once

cp /usr/local/consul-watch/result /usr/local/hadoop-2.7.2/etc/hadoop/yarn.include
cp /usr/local/consul-watch/result /usr/local/hadoop-2.7.2/etc/hadoop/dfs.include
cp /usr/local/consul-watch/result /usr/local/hadoop-2.7.2/etc/hadoop/slaves

yarn rmadmin -refreshNodes

hdfs dfsadmin -refreshNodes