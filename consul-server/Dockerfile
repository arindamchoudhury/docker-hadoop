FROM arindamchoudhury/consul
COPY config/server.json /usr/local/consul/config/server.json
RUN source /etc/profile
ENTRYPOINT ["/usr/local/consul/bin/consul", "agent", "-server", "-config-dir=/usr/local/consul/config", "-client=0.0.0.0", "-data-dir=/usr/local/consul/data"]