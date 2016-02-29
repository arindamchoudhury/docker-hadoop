FROM arindamchoudhury/hadoop-base:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

# move all confugration files into container

ENV HADOOP_INSTALL /usr/local/hadoop-2.7.2

RUN mkdir -p /var/data/hadoop/hdfs/nn && \
mkdir $HADOOP_INSTALL/logs && \
chown -R hdfs:hadoop /var/data/hadoop/hdfs/nn && \
chown -R hdfs:hadoop $HADOOP_INSTALL && \
chmod 0777 $HADOOP_INSTALL && \
mkdir -p /usr/local/consul-watch

ADD ./config /usr/local/consul/config/

ADD files/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml
ADD files/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml
ADD files/mapred-site.xml $HADOOP_INSTALL/etc/hadoop/mapred-site.xml
ADD files/yarn-site.xml $HADOOP_INSTALL/etc/hadoop/yarn-site.xml

ADD files/start-hadoop.sh /root/start-hadoop.sh
ADD files/run-wordcount.sh /root/run-wordcount.sh

ADD files/my-service-handler.sh /usr/local/consul-watch/my-service-handler.sh
ADD files/template.cfg /usr/local/consul-watch/template.cfg
ADD files/template.ctmpl /usr/local/consul-watch/template.ctmpl
ADD files/watch-helper.py /usr/local/consul-watch/watch-helper.py

ADD files/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

RUN chmod +x ~/start-hadoop.sh && \
chmod +x ~/run-wordcount.sh && \
chmod +x /usr/local/consul-watch/my-service-handler.sh && \
chmod +x /usr/local/consul-watch/watch-helper.py

RUN touch $HADOOP_INSTALL/etc/hadoop/dfs.include && \
touch $HADOOP_INSTALL/etc/hadoop/yarn.include && \
touch $HADOOP_INSTALL/etc/hadoop/slaves

# format namenode
RUN sudo -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs namenode -format

ADD tars/ /tmp/

#RUN wget -c -O "apache-hive-1.2.1-bin.tar.gz" "http://apache.rediris.es/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz" && \
RUN tar zxf /tmp/apache-hive-1.2.1-bin.tar.gz -C /usr/local/ && \
rm /tmp/apache-hive-1.2.1-bin.tar.gz

ENV HIVE_HOME /usr/local/apache-hive-1.2.1-bin
ENV PATH $HIVE_HOME/bin:$PATH


EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060

CMD ["/usr/bin/supervisord"]
