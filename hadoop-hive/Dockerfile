FROM arindamchoudhury/hadoop-base:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

WORKDIR /root/

# move all confugration files into container

ENV HADOOP_INSTALL /usr/local/hadoop-2.7.2

RUN mkdir -p /var/data/hadoop/hdfs/nn && \
mkdir $HADOOP_INSTALL/logs && \
chown -R hdfs:hadoop /var/data/hadoop/hdfs/nn && \
mkdir -p /usr/local/consul-watch

COPY ./config /usr/local/consul/config/

COPY files/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml
COPY files/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml
COPY files/mapred-site.xml $HADOOP_INSTALL/etc/hadoop/mapred-site.xml
COPY files/yarn-site.xml $HADOOP_INSTALL/etc/hadoop/yarn-site.xml

COPY files/bootstrap.sh /etc/bootstrap.sh
RUN chmod +x /etc/bootstrap.sh

COPY files/start-hadoop.sh /root/start-hadoop.sh
COPY files/run-wordcount.sh /root/run-wordcount.sh

COPY files/my-service-handler.sh /usr/local/consul-watch/my-service-handler.sh
COPY files/template.cfg /usr/local/consul-watch/template.cfg
COPY files/template.ctmpl /usr/local/consul-watch/template.ctmpl
COPY files/watch-helper.py /usr/local/consul-watch/watch-helper.py

COPY files/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

RUN chmod +x ~/start-hadoop.sh && \
chmod +x ~/run-wordcount.sh && \
chmod +x /usr/local/consul-watch/my-service-handler.sh && \
chmod +x /usr/local/consul-watch/watch-helper.py && \
chmod +x /etc/bootstrap.sh

RUN touch $HADOOP_INSTALL/etc/hadoop/dfs.include && \
touch $HADOOP_INSTALL/etc/hadoop/yarn.include && \
touch $HADOOP_INSTALL/etc/hadoop/slaves

# format namenode
RUN sudo -E -u hdfs /usr/local/hadoop-2.7.2/bin/hdfs namenode -format

COPY tars/ /tmp/

#RUN wget -c -O "apache-hive-1.2.1-bin.tar.gz" "http://apache.rediris.es/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz" && \
RUN tar zxf /tmp/apache-hive-1.2.1-bin.tar.gz -C /usr/local/ && \
rm /tmp/apache-hive-1.2.1-bin.tar.gz

COPY ./files/hive.sh /etc/profile.d/hive.sh

RUN source /etc/profile

ENV HIVE_HOME /usr/local/apache-hive-1.2.1-bin
ENV PATH $HIVE_HOME/bin:$PATH


EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060

#CMD ["/usr/bin/supervisord"]
CMD ["/etc/bootstrap.sh", "-d"]
