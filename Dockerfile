FROM ubuntu:18.04

ARG FMEDL="https://downloads.safe.com/fme/2019/fme-desktop-2019_2019.2.2.0.19817~ubuntu.18.04_amd64.deb"
ARG TZ="Europe/Stockholm"
ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get -q update \
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
 && rm -rf /var/lib/apt/lists/* /opt/* \
 && mkdir -p fme
 
 ENV PATH="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/fme"
 
