FROM arindamchoudhury/consul-agent:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# install required packages
RUN apt-get update && \
apt-get install -y ntp libsnappy1 libsnappy-dev liblzo2-2 liblzo2-dev python-psutil libxml2-utils libssl1.0.0 libssl-dev
#openssh-server

COPY tars/jdk-7u80-linux-x64.tar.gz /tmp/jdk-7u80-linux-x64.tar.gz
COPY tars/hadoop-2.7.2.tar.gz /tmp/hadoop-2.7.2.tar.gz

#Download jdk-7u79 and extract to /usr/local/
RUN apt-get purge openjdk*
#RUN wget -c -O "jdk-7u80-linux-x64.tar.gz" --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz" && \
RUN tar zxf /tmp/jdk-7u80-linux-x64.tar.gz -C /usr/local/ && \
rm /tmp/jdk-7u80-linux-x64.tar.gz
#Setup Java environment
COPY files/java.sh /etc/profile.d/java.sh

# Download Hadoop and extract to /usr/local/
#RUN wget -c -O "hadoop-2.7.2.tar.gz" "http://apache.rediris.es/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz" && \
RUN tar zxf /tmp/hadoop-2.7.2.tar.gz -C /usr/local/ && \
rm /tmp/hadoop-2.7.2.tar.gz

# Setup hadoop environment
COPY files/hadoop.sh /etc/profile.d/hadoop.sh

# Modify hadoop-env.sh
RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/local/jdk1.7.0_80\nexport HADOOP_PREFIX=/usr/local/hadoop-2.7.2\nexport HADOOP_HOME=/usr/local/hadoop-2.7.2\n:' /usr/local/hadoop-2.7.2/etc/hadoop/hadoop-env.sh
RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop-2.7.2/etc/hadoop/:' /usr/local/hadoop-2.7.2/etc/hadoop/hadoop-env.sh

# move all configuration files into container
#COPY files/ssh_config ~/.ssh/config/ssh_config

#configure ssh free key access
#RUN mkdir /var/run/sshd && \
#ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
#sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#create users and groups
RUN groupadd hadoop && \
useradd -g hadoop -m -s /bin/bash yarn && \
useradd -g hadoop -m -s /bin/bash hdfs && \
useradd -g hadoop -m -s /bin/bash mapred && \
useradd -g hadoop -m -s /bin/bash hive

RUN mkdir /var/log/hadoop && \
chgrp -R hadoop /var/log/hadoop && \
chmod -R g+rwxs /var/log/hadoop

COPY files/hdfs-site.xml /tmp/hdfs-site.xml.ctmpl
COPY files/core-site.xml /tmp/core-site.xml.ctmpl
COPY files/mapred-site.xml /tmp/mapred-site.xml.ctmpl
COPY files/yarn-site.xml /tmp/yarn-site.xml.ctmpl

COPY files/memory_config.py /etc/memory_config.py
RUN chmod +x /etc/memory_config.py