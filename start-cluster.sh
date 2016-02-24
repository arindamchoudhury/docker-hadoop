#!/bin/bash

# run N slave containers
N=$1

# the defaut node number is 3
if [ $# = 0 ]
then
	N=3
fi

docker rm -f consul-server &> /dev/null
echo "start consul-server container..."
docker run -d --name=consul-server -h server  --dns-search node.dc1.arindamdomain.com  --dns 127.0.0.1 arindamchoudhury/consul-server  -bootstrap

SERVER_IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" consul-server)

# delete old master container and start new master container
docker rm -f master &> /dev/null
echo "start master container..."
docker run -e CONSUL_SERVER_ADDR=$SERVER_IP -d -h master --dns-search node.dc1.arindamdomain.com --dns 127.0.0.1 --name=master arindamchoudhury/hadoop-master &> /dev/null

# get the IP address of master container
# delete old slave containers and start new slave containers
i=1
while [ $i -lt $N ]
do
	docker rm -f slave$i &> /dev/null
	echo "start slave$i container..."
	docker run -e CONSUL_SERVER_ADDR=$SERVER_IP -d -h slave$i --dns-search node.dc1.arindamdomain.com --dns 127.0.0.1 --name=slave$i arindamchoudhury/hadoop-slave  &> /dev/null
	((i++))
done 


# create a new Bash session in the master container
docker exec -it master bash
