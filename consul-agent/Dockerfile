FROM arindamchoudhury/consul
ADD ./config /usr/local/consul/config/
EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53 53/udp
RUN source /etc/profile
ENTRYPOINT ["/usr/local/consul/bin/consul", "agent", "-config-dir=/usr/local/consul/config"]