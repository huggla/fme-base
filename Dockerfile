FROM ubuntu:18.04

ARG FMEDL="https://downloads.safe.com/fme/2019/fme-desktop-2019_2019.2.2.0.19817~ubuntu.18.04_amd64.deb"

RUN apt update \
 && apt-get -y install wget \
 && mkdir -p /tmp/dl \
 && cd /tmp/dl \
 && wget $FMEDL \
 && apt-get -y purge wget \
 && apt-get -y autoremove \
 && dpkg -i *.deb ; rm -rf /tmp/dl \
 && apt-get -y install -f \
 && cd /opt \
 && ln -s $(ls /opt) fme
 
 ENV PATH="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/fme"
