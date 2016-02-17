FROM ubuntu:14.04

MAINTAINER Arindam Choudhury <arindam@live.com>

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && \
apt-get install -y unzip wget

# Download and extract consul
RUN wget -c -O "consul_0.6.3_linux_amd64.zip" "https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_linux_amd64.zip" && \
mkdir -p /usr/local/consul/ && \
unzip consul_0.6.3_linux_amd64.zip -d /usr/local/consul/ && \
rm consul_0.6.3_linux_amd64.zip

#Setup Consul environment
RUN touch /etc/profile.d/consul.sh && \
echo '#!/bin/bash' >> /etc/profile.d/consul.sh && \
echo 'PATH=/usr/local/consul/:$PATH' >> /etc/profile.d/consul.sh && \
echo 'export PATH' >> /etc/profile.d/consul.sh && \
source /etc/profile



