FROM arindamchoudhury/consul

COPY config/server.json /usr/local/consul/config/server.json
COPY files/env.list /usr/local/consul/env.list

ENTRYPOINT ["/usr/local/consul/bin/consul", "agent", "-server", "-config-dir=/usr/local/consul/config", "--env-file /usr/local/consul/env.list","-client=0.0.0.0", "-data-dir=/usr/local/consul/data"]