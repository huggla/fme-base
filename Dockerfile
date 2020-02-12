FROM ubuntu:18.04

ARG TZ="Europe/Stockholm"
ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get -q update \
 && apt-get -qy --no-install-recommends install libtcmalloc-minimal4 libqt5core5a libboost-system1.65.1 libboost-thread1.65.1 libtcl8.5 libjpeg-turbo8 libfreetype6 libssl1.1 libssh2-1 libboost-filesystem1.65.1 libboost-regex1.65.1 libboost-iostreams1.65.1 libcgroup1 libqt5network5 libboost-locale1.65.1 libsqlite3-0 libmpfr6 libexpat1 libxml2 libqt5sql5 \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /opt/fme \
 && echo '#!/bin/bash' > /usr/local/bin/run_work \
 && echo 'while true; do executable="$(ls | head -n 1)"; if [ -n "$executable" ]; then echo "Executing /work/$executable"; "./$executable"; echo "Deleting /work/$executable"; rm "$executable"; fi; sleep 1; done' >> /usr/local/bin/run_work \
 && chmod +x /usr/local/bin/run_work \
 && useradd --create-home --home /work --shell /bin/bash worker \
 && ln -fs /usr/share/$TZ /etc/localtime \
 && dpkg-reconfigure --frontend noninteractive tzdata

USER worker
WORKDIR /work

ENV PATH="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/fme"

CMD ["run_work"]
