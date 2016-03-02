FROM arindamchoudhury/hadoop-base:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

WORKDIR /home/hdfs

ENV HADOOP_INSTALL /usr/local/hadoop-2.7.2

RUN mkdir -p /var/data/hadoop/hdfs/dn && \
chown -R hdfs:hadoop /var/data/hadoop/hdfs/dn && \
chgrp -R hadoop $HADOOP_INSTALL && \
chmod -R g+rwxs $HADOOP_INSTALL

COPY files/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml
COPY files/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml
COPY files/mapred-site.xml $HADOOP_INSTALL/etc/hadoop/mapred-site.xml
COPY files/yarn-site.xml $HADOOP_INSTALL/etc/hadoop/yarn-site.xml

COPY files/bootstrap.sh /etc/bootstrap.sh
RUN chmod +x /etc/bootstrap.sh

EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060

COPY /config/service.json /usr/local/consul/config/service.json

CMD ["/etc/bootstrap.sh", "-d"]
