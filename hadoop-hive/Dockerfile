FROM arindamchoudhury/hadoop-master:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

WORKDIR /home/hdfs

# move all confugration files into container

ENV HADOOP_INSTALL /usr/local/hadoop-2.7.2

COPY files/bootstrap.sh /etc/bootstrap.sh
RUN chmod +x /etc/bootstrap.sh

RUN chmod +x /etc/bootstrap.sh

COPY tars/apache-hive-1.2.1-bin.tar.gz /tmp/apache-hive-1.2.1-bin.tar.gz

#RUN wget -c -O "apache-hive-1.2.1-bin.tar.gz" "http://apache.rediris.es/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz" && \
RUN tar zxf /tmp/apache-hive-1.2.1-bin.tar.gz -C /usr/local/ && \
rm /tmp/apache-hive-1.2.1-bin.tar.gz

COPY files/hive.sh /etc/profile.d/hive.sh

RUN source /etc/profile

ENV HIVE_HOME /usr/local/apache-hive-1.2.1-bin
ENV PATH $HIVE_HOME/bin:$PATH

CMD ["/etc/bootstrap.sh", "-d"]
