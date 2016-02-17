FROM arindamchoudhury/consul
ADD ./config /usr/local/consul/config
ENTRYPOINT ["/usr/local/consul/bin/consul", "agent", "-server", "-config-dir=/usr/local/consul/config"]