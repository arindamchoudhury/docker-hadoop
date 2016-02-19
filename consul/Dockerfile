FROM ubuntu:14.04

MAINTAINER Arindam Choudhury <arindam@live.com>

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV CONSUL_VERSION 0.6.3
ENV CONSUL_SHA256 b0532c61fec4a4f6d130c893fd8954ec007a6ad93effbe283a39224ed237e250

RUN apt-get update && \
apt-get install -y unzip wget curl && \
apt-get install -y dnsmasq

#add consul dnsmasq config
ADD ./dnsmasq /etc/dnsmasq.d/

# Download and extract consul
RUN wget -c -O "consul_0.6.3_linux_amd64.zip" "https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_linux_amd64.zip" && \
mkdir -p /usr/local/consul/bin && \
unzip consul_0.6.3_linux_amd64.zip -d /usr/local/consul/bin && \
rm consul_0.6.3_linux_amd64.zip

# Download and extract consul-template
RUN wget -c -O "consul-template_0.13.0_linux_amd64.zip" "https://releases.hashicorp.com/consul-template/0.13.0/consul-template_0.13.0_linux_amd64.zip" && \
mkdir -p /usr/local/consul/bin && \
unzip consul-template_0.13.0_linux_amd64.zip -d /usr/local/consul/bin && \
rm consul-template_0.13.0_linux_amd64.zip

#Setup Consul environment
RUN touch /etc/profile.d/consul.sh && \
echo '#!/bin/bash' >> /etc/profile.d/consul.sh && \
echo 'PATH=/usr/local/consul/bin/:$PATH' >> /etc/profile.d/consul.sh && \
echo 'export PATH' >> /etc/profile.d/consul.sh && \
source /etc/profile

ENTRYPOINT ["/usr/local/consul/bin/consul"]
