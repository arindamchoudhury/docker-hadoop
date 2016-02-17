FROM arindamchoudhury/consul
ADD ./config /config/
ENTRYPOINT ["/usr/local/consul/consul", "agent", "-server", "-config-dir=/config"]