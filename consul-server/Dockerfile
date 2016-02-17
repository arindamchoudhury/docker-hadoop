FROM arindamchoudhury/consul
ADD ./config /config/
ENTRYPOINT ["/usr/local/consul/consul", "agent", "-server", "-config-dir=/usr/local/consul/config", "-data-dir=/usr/local/consul/data"]