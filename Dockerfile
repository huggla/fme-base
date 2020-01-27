FROM ubuntu:18.04

ARG FMEDL="https://downloads.safe.com/fme/2019/fme-desktop-2019_2019.2.2.0.19817~ubuntu.18.04_amd64.deb"

RUN apt update \
 && apt -y install wget \
 && mkdir -p /tmp/dl \
 && cd /tmp/dl \
 && wget $FMEDL \
 && apt -y purge wget \
 && dpkg -i *.deb \
 && apt install -f \
 && rm -rf /tmp/dl
