FROM arindamchoudhury/serf-dnsmasq:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# install openssh-server, wget
RUN apt-get update && \
apt-get install -y openssh-server wget

# Download Java nd extract to /usr/local/
RUN wget -c -O "jdk-8u73-linux-x64.tar.gz" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.tar.gz" && \ 
tar zxf jdk-8u73-linux-x64.tar.gz -C /usr/local/ && \ 
rm jdk-8u73-linux-x64.tar.gz
#Setup Java environment
RUN touch /etc/profile.d/java.sh && \ 
echo '#!/bin/bash' >> /etc/profile.d/java.sh && \ 
echo 'JAVA_HOME=/usr/local/jdk1.8.0_73/' >> /etc/profile.d/java.sh && \ 
echo 'PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/java.sh && \ 
echo 'export JAVA_HOME PATH' >> /etc/profile.d/java.sh && \ 
chmod +x /etc/profile.d/java.sh && \ 
source /etc/profile.d/java.sh


# Download Hadoop and extract to /usr/local/
RUN wget -c -O "hadoop-2.7.2.tar.gz" "http://apache.rediris.es/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz" && \
tar zxf hadoop-2.7.2.tar.gz -C /usr/local/ && \
rm hadoop-2.7.2.tar.gz

# Setup hadoop environment
RUN touch /etc/profile.d/hadoop.sh && \ 
echo '#!/bin/bash' >> /etc/profile.d/hadoop.sh && \ 
echo 'HADOOP_PREFIX=/usr/local/hadoop-2.7.2/' >> /etc/profile.d/hadoop.sh && \
echo 'HADOOP_COMMON_HOME=$HADOOP_PREFIX' >> /etc/profile.d/hadoop.sh && \
echo 'HADOOP_HDFS_HOME=$HADOOP_PREFIX' >> /etc/profile.d/hadoop.sh && \
echo 'HADOOP_MAPRED_HOME=$HADOOP_PREFIX' >> /etc/profile.d/hadoop.sh && \
echo 'HADOOP_YARN_HOME=$HADOOP_PREFIX' >> /etc/profile.d/hadoop.sh && \
echo 'HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop' >> /etc/profile.d/hadoop.sh && \
echo 'YARN_CONF_DIR=$HADOOP_PREFIX/etc/hadoop' >> /etc/profile.d/hadoop.sh && \
echo 'PATH=$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin:$PATH' >> /etc/profile.d/hadoop.sh && \ 
echo 'export HADOOP_PREFIX HADOOP_COMMON_HOME HADOOP_HDFS_HOME HADOOP_MAPRED_HOME HADOOP_YARN_HOME HADOOP_CONF_DIR YARN_CONF_DIR PATH' >> /etc/profile.d/hadoop.sh && \ 
chmod +x /etc/profile.d/hadoop.sh && \ 
source /etc/profile.d/hadoop.sh

# Modify hadoop-env.sh
RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/local/jdk1.8.0_73\nexport HADOOP_PREFIX=/usr/local/hadoop-2.7.2\nexport HADOOP_HOME=/usr/local/hadoop-2.7.2\n:' /usr/local/hadoop-2.7.2/etc/hadoop/hadoop-env.sh
RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop-2.7.2/etc/hadoop/:' /usr/local/hadoop-2.7.2/etc/hadoop/hadoop-env.sh


# move all configuration files into container
ADD files/ /usr/local/

#configure ssh free key access
RUN mkdir /var/run/sshd && \
ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
mv /usr/local/ssh_config ~/.ssh/config && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
