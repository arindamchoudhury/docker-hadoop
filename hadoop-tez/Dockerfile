FROM arindamchoudhury/hadoop-master:latest

MAINTAINER Arindam Choudhury <arindam@live.com>

WORKDIR /home/hdfs

COPY files/bootstrap.sh /etc/bootstrap.sh
RUN chmod +x /etc/bootstrap.sh

COPY files/tez-0.8.2.tar.gz /tmp/tez-0.8.2.tar.gz

CMD ["/etc/bootstrap.sh", "-d"]


