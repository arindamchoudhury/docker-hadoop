FROM arindamchoudhury/hadoop-base:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

WORKDIR /root/
# move all confugration files into container

ENV HADOOP_INSTALL /usr/local/hadoop-2.7.2

RUN mkdir -p ~/hdfs/namenode && \ 
mkdir -p ~/hdfs/datanode && \
mkdir $HADOOP_INSTALL/logs

ADD ./config /usr/local/consul/config/

ADD files/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml
ADD files/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml
ADD files/mapred-site.xml $HADOOP_INSTALL/etc/hadoop/mapred-site.xml
ADD files/yarn-site.xml $HADOOP_INSTALL/etc/hadoop/yarn-site.xml
ADD files/slaves $HADOOP_INSTALL/etc/hadoop/slaves

ADD files/start-hadoop.sh /root/start-hadoop.sh
ADD files/run-wordcount.sh /root/run-wordcount.sh

ADD files/my-service-handler.sh /root/my-service-handler.sh
ADD files/template.cfg /tmp/template.cfg
ADD files/template.ctmpl /tmp/template.ctmpl

ADD files/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

RUN chmod +x ~/start-hadoop.sh && \
chmod +x ~/run-wordcount.sh && \
chmod +x ~/my-service-handler.sh

# format namenode
RUN /usr/local/hadoop-2.7.2/bin/hdfs namenode -format

EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060

CMD ["/usr/bin/supervisord"]
