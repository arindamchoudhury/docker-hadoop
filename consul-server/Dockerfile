FROM arindamchoudhury/consul

MAINTAINER Arindam Choudhury <arindam@live.com>

COPY config/server.json /usr/local/consul/config/server.json

ENTRYPOINT ["/usr/local/consul/bin/consul", "agent", "-server", "-config-dir=/usr/local/consul/config","-client=0.0.0.0", "-data-dir=/usr/local/consul/data"]