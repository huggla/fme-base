FROM ubuntu:18.04

ARG DEBIAN_FRONTEND="noninteractive"
ARG LINUX_USER="fme"

ENV TZ="Europe/Stockholm"

RUN apt-get -q update \
 && apt-get -qy --no-install-recommends install libtcmalloc-minimal4 libqt5core5a libboost-system1.65.1 libboost-thread1.65.1 libtcl8.5 libjpeg-turbo8 libfreetype6 libssl1.1 libssh2-1 libboost-filesystem1.65.1 libboost-regex1.65.1 libboost-iostreams1.65.1 libcgroup1 libqt5network5 libboost-locale1.65.1 libsqlite3-0 libmpfr6 libexpat1 libxml2 libqt5sql5 \
 && rm -rf /var/lib/apt/lists/* \
 && echo '#!/bin/bash' > /usr/local/bin/execute-service \
 && echo 'while true; do executable="$(ls /execute-dir | head -n 1)"; if [ -n "$executable" ]; then echo "Executing $executable"; "/execute-dir/$executable"; echo "Deleting $executable"; rm "/execute-dir/$executable"; fi; sleep 1; done' >> /usr/local/bin/execute-service \
 && chmod +x /usr/local/bin/execute-service \
 && useradd --create-home --shell /bin/bash $LINUX_USER \
 && mkdir -p /opt/fme /execute-dir /fme-shared \
 && chown $LINUX_USER:$LINUX_USER /fme-shared \
 && ln -s /fme-shared /home/$LINUX_USER/.fme \
 && ln -fns /usr/share/zoneinfo/$TZ /etc/localtime \
 && echo $TZ > /etc/timezone

USER $LINUX_USER
WORKDIR /workspaces

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/fme" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8"

CMD ["execute-service"]
