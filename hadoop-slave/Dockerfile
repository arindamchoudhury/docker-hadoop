FROM arindamchoudhury/hadoop-base:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

WORKDIR /root/

# move all confugration /tmp into container
ADD files/* /tmp/
ADD files/bootstrap.sh /etc/bootstrap.sh
RUN chmod +x /etc/bootstrap.sh

ENV HADOOP_INSTALL /usr/local/hadoop-2.7.2

RUN mkdir -p /var/data/hadoop/hdfs/dn && \
mkdir $HADOOP_INSTALL/logs && \
chown -R hdfs:hadoop /var/data/hadoop/hdfs/dn && \
chgrp -R hadoop $HADOOP_INSTALL && \
chmod -R g+rwxs $HADOOP_INSTALL

RUN mv /tmp/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml && \
mv /tmp/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml && \
mv /tmp/mapred-site.xml $HADOOP_INSTALL/etc/hadoop/mapred-site.xml && \
mv /tmp/yarn-site.xml $HADOOP_INSTALL/etc/hadoop/yarn-site.xml 

EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060

ADD ./config /usr/local/consul/config/
ADD files/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

#CMD ["/usr/bin/supervisord"]
CMD ["/etc/bootstrap.sh", "-d"]
