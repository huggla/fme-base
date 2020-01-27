FROM ubuntu:18.04

ARG FMEDL="https://downloads.safe.com/fme/2019/fme-desktop-2019_2019.2.2.0.19817~ubuntu.18.04_amd64.deb"
ARG TZ="Europe/Stockholm"

RUN DEBIAN_FRONTEND=noninteractive \
 && apt-get -q update \
 && apt-get -y install wget \
 && mkdir -p /tmp/dl \
 && cd /tmp/dl \
 && wget -q $FMEDL \
 && apt-get -y purge wget \
 && apt-get -y autoremove \
 && dpkg -i *.deb ; cd /opt \
 && rm -rf /tmp/dl \
 && apt-get -y install -f \
 && ln -fs /usr/share/$TZ /etc/localtime \
 && dpkg-reconfigure --frontend noninteractive tzdata \
 && ln -s $(ls /opt) fme \
 && rm -rf /var/lib/apt/lists/*
 
 ENV PATH="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/fme"
 
