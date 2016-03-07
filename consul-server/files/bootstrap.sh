#!/usr/bin/env bash

source /etc/profile

nohup /usr/local/consul/bin/consul agent  -server -config-dir /usr/local/consul/config --domain=$CONSUL_DOMAIN_NAME  -client=0.0.0.0 -data-dir=/usr/local/consul/data >>/var/log/consul.log 2>&1 &

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
