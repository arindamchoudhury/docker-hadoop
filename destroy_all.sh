#!/usr/bin/env bash

docker rmi arindamchoudhury/hadoop-master arindamchoudhury/hadoop-slave arindamchoudhury/hadoop-base arindamchoudhury/consul-server arindamchoudhury/consul-agent arindamchoudhury/consul
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

