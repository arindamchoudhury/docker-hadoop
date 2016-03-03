FROM arindamchoudhury/hadoop-base:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

WORKDIR /home/hdfs

# move all confugration files into container

RUN mkdir -p /var/data/hadoop/hdfs/nn && \
chown -R hdfs:hadoop /var/data/hadoop/hdfs/nn && \
mkdir -p /usr/local/consul-watch

COPY config/service.json /usr/local/consul/config/service.json
COPY config/watches.json /usr/local/consul/config/watches.json

COPY files/bootstrap.sh /etc/bootstrap.sh
RUN chmod +x /etc/bootstrap.sh

COPY files/my-service-handler.sh /usr/local/consul-watch/my-service-handler.sh
COPY files/template.cfg /usr/local/consul-watch/template.cfg
COPY files/template.ctmpl /usr/local/consul-watch/template.ctmpl


RUN chmod +x /usr/local/consul-watch/my-service-handler.sh && \
chmod +x /etc/bootstrap.sh

RUN touch $HADOOP_INSTALL/etc/hadoop/dfs.include && \
touch $HADOOP_INSTALL/etc/hadoop/yarn.include && \
touch $HADOOP_INSTALL/etc/hadoop/slaves

# format namenode
#RUN source /etc/profile
#RUN sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs namenode -format

EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060

CMD ["/etc/bootstrap.sh", "-d"]
