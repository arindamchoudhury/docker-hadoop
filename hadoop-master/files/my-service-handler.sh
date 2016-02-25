#!/usr/bin/env bash
consul-template -config /usr/local/consul-watch/template.cfg -once
echo "hulu" >>/usr/local/consul-watch/hulu
./usr/local/consul-watch/watch-helper.py