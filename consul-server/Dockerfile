FROM arindamchoudhury/consul
ADD ./config /usr/local/consul/config
ENTRYPOINT ["/usr/local/consul/consul", "agent", "-server", "-config-dir=/usr/local/consul/config", "-data-dir=/usr/local/consul/data"]