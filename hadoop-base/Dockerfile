FROM arindamchoudhury/consul-agent:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# install required packages
RUN apt-get update && \
apt-get install -y openssh-server wget && \
apt-get install -y libsnappy1 libsnappy-dev liblzo2-2 liblzo2-dev


ADD tars/ /tmp/

#Download jdk-7u79 and extract to /usr/local/
RUN apt-get purge openjdk*
#RUN wget -c -O "jdk-7u80-linux-x64.tar.gz" --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz" && \
RUN tar zxf /tmp/jdk-7u80-linux-x64.tar.gz -C /usr/local/ && \
rm /tmp/jdk-7u80-linux-x64.tar.gz
#Setup Java environment
RUN touch /etc/profile.d/java.sh && \
echo 'JAVA_HOME=/usr/local/jdk1.7.0_80/' >> /etc/profile.d/java.sh && \
echo 'PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/java.sh && \
echo 'export JAVA_HOME PATH' >> /etc/profile.d/java.sh && \
chmod +x /etc/profile.d/java.sh
ENV JAVA_HOME /usr/local/jdk1.7.0_80
ENV PATH $JAVA_HOME/bin:$PATH

# Download Hadoop and extract to /usr/local/
#RUN wget -c -O "hadoop-2.7.2.tar.gz" "http://apache.rediris.es/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz" && \
RUN tar zxf /tmp/hadoop-2.7.2.tar.gz -C /usr/local/ && \
rm /tmp/hadoop-2.7.2.tar.gz

# Setup hadoop environment
RUN touch /etc/profile.d/hadoop.sh && \
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
source /etc/profile

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
ADD files/ /tmp/

#configure ssh free key access
RUN mkdir /var/run/sshd && \
ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
mv /tmp/ssh_config ~/.ssh/config && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN apt-get -y install supervisor ntp && \
mkdir -p /var/log/supervisor && \
mkdir -p /etc/supervisor/conf.d

#create users and groups
RUN addgroup hadoop --disabled-password --disabled-login && \
adduser yarn && \
adduser yarn hadoop && \
adduser hdfs hadoop && \
adduser mapred hadoop

#Create directories
RUN mkdir -p /var/data/hadoop/hdfs/nn && \
mkdir -p /var/data/hadoop/hdfs/snn && \
mkdir -p /var/data/hadoop/hdfs/dn && \
chown hdfs:hadoop /var/data/hadoop/hdfs -R

