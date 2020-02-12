FROM ubuntu:18.04

RUN set -x \
 && apt-get -q update \
 && apt-get -y --no-install-recommends install libtcmalloc-minimal4 libqt5core5a libboost-system1.65.1 libboost-thread1.65.1 libtcl8.5 libjpeg-turbo8 libfreetype6 libssl1.1 libssh2-1 libboost-filesystem1.65.1 libboost-regex1.65.1 libboost-iostreams1.65.1 libcgroup1 libqt5network5 libboost-locale1.65.1 libsqlite3-0 libmpfr6 libexpat1 libxml2 libqt5sql5 \
 && rm -rf /var/lib/apt/lists/* /opt/* \
 && mkdir -p /opt/fme
 
 ENV PATH="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/fme"
 
WORKDIR /work
ENTRYPOINT ["/bin/sh", "-c"]
CMD ['while true; do (executable="$(ls | head -n 1)" && (./$executable; rm $executable)); sleep 1; done']
