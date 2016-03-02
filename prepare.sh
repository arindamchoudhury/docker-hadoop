#!/usr/bin/env bash

mkdir -p hadoop-base/tars
mkdir -p hadoop-master/tars

cd hadoop-base/tars

wget -c -O "jdk-7u80-linux-x64.tar.gz" --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz"
wget -c -O "hadoop-2.7.2.tar.gz" "http://apache.rediris.es/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz"

cd ../../hadoop-master/tars

wget -c -O "apache-hive-1.2.1-bin.tar.gz" "http://apache.rediris.es/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz"
