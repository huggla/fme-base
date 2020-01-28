FROM ubuntu:18.04

ARG FMEDL="https://downloads.safe.com/fme/2019/fme-desktop-2019_2019.2.2.0.19817~ubuntu.18.04_amd64.deb"

RUN set -x \
 && apt-get -q update \
 && apt-get -y --no-install-recommends install wget xrdp \
 && mkdir -p /tmp/dl \
 && cd /tmp/dl \
 && wget --no-check-certificate $FMEDL \
 && apt-get -y purge wget \
 && apt-get -y autoremove \
 && dpkg -i *.deb ; cd / \
 && rm -rf /tmp/dl \
 && apt-get -y --no-install-recommends install -f \
 && rm -rf /var/lib/apt/lists/* /opt/* \
 && mkdir -p /opt/fme
 
 ENV PATH="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/fme"
 
