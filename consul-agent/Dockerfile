FROM arindamchoudhury/consul
ADD ./config /usr/local/consul/config/
RUN source /etc/profile
#ENTRYPOINT ["/usr/local/consul/bin/consul", "agent", "-config-dir=/usr/local/consul/config"]