FROM arindamchoudhury/hadoop-master:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive


# download and extract hive-2.0.0
RUN wget -c -O "apache-hive-2.0.0-bin.tar.gz" "http://apache.rediris.es/hive/hive-2.0.0/apache-hive-2.0.0-bin.tar.gz" && \
tar zxf apache-hive-2.0.0-bin.tar.gz -C /usr/local/ && \
rm hadoop-2.7.2.tar.gz

# setup hive environment

#Setup Java environment
RUN touch /etc/profile.d/hive.sh && \
echo '#!/bin/bash' >> /etc/profile.d/hive.sh && \
echo 'HIVE_HOME=/usr/local/apache-hive-2.0.0-bin/' >> /etc/profile.d/hive.sh && \
echo 'PATH=$HIVE_HOME/bin:$PATH' >> /etc/profile.d/hive.sh && \
echo 'export HIVE_HOME PATH' >> /etc/profile.d/hive.sh && \
chmod +x /etc/profile.d/hive.sh && \
source /etc/profile

