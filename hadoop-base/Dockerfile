FROM arindamchoudhury/consul-agent:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# install required packages
RUN apt-get update && \
apt-get install -y openssh-server ntp libsnappy1 libsnappy-dev liblzo2-2 liblzo2-dev python-psutil

COPY tars/jdk-7u80-linux-x64.tar.gz /tmp/jdk-7u80-linux-x64.tar.gz
COPY tars/hadoop-2.7.2.tar.gz /tmp/hadoop-2.7.2.tar.gz

#Download jdk-7u79 and extract to /usr/local/
RUN apt-get purge openjdk*
#RUN wget -c -O "jdk-7u80-linux-x64.tar.gz" --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz" && \
RUN tar zxf /tmp/jdk-7u80-linux-x64.tar.gz -C /usr/local/ && \
rm /tmp/jdk-7u80-linux-x64.tar.gz
#Setup Java environment
COPY files/java.sh /etc/profile.d/java.sh

ENV JAVA_HOME /usr/local/jdk1.7.0_80
ENV PATH $JAVA_HOME/bin:$PATH

# Download Hadoop and extract to /usr/local/
#RUN wget -c -O "hadoop-2.7.2.tar.gz" "http://apache.rediris.es/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz" && \
RUN tar zxf /tmp/hadoop-2.7.2.tar.gz -C /usr/local/ && \
rm /tmp/hadoop-2.7.2.tar.gz

# Setup hadoop environment
COPY files/hadoop.sh /etc/profile.d/hadoop.sh

ENV HADOOP_PREFIX /usr/local/hadoop-2.7.2
ENV HADOOP_COMMON_HOME $HADOOP_PREFIX
ENV HADOOP_HDFS_HOME $HADOOP_PREFIX
ENV HADOOP_MAPRED_HOME $HADOOP_PREFIX
ENV HADOOP_YARN_HOME $HADOOP_PREFIX
ENV HADOOP_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin:$PATH


# Modify hadoop-env.sh
RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/local/jdk1.7.0_80\nexport HADOOP_PREFIX=/usr/local/hadoop-2.7.2\nexport HADOOP_HOME=/usr/local/hadoop-2.7.2\n:' /usr/local/hadoop-2.7.2/etc/hadoop/hadoop-env.sh
RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop-2.7.2/etc/hadoop/:' /usr/local/hadoop-2.7.2/etc/hadoop/hadoop-env.sh

# move all configuration files into container
COPY files/ssh_config ~/.ssh/config/ssh_config

#configure ssh free key access
RUN mkdir /var/run/sshd && \
ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#create users and groups
RUN groupadd hadoop && \
useradd -g hadoop -m -s /bin/bash yarn && \
useradd -g hadoop -m -s /bin/bash hdfs && \
useradd -g hadoop -m -s /bin/bash mapred && \
useradd -g hadoop -m -s /bin/bash hive

ENV HADOOP_LOG_DIR /var/log/hadoop
ENV YARN_LOG_DIR /var/log/hadoop

RUN mkdir $HADOOP_LOG_DIR && \
chgrp -R hadoop $HADOOP_PREFIX && \
chmod -R g+rwxs $HADOOP_PREFIX && \
chgrp -R hadoop $HADOOP_LOG_DIR && \
chmod -R g+rwxs $HADOOP_LOG_DIR