FROM ubuntu:18.04

ARG DEBIAN_FRONTEND="noninteractive"
ARG LINUX_USER="fme"

ENV TZ="Europe/Stockholm"

RUN apt-get -q update \
 && apt-get -qy --no-install-recommends install libtcmalloc-minimal4 libqt5core5a libboost-system1.65.1 libboost-thread1.65.1 libtcl8.5 libjpeg-turbo8 libfreetype6 libssl1.1 libssh2-1 libboost-filesystem1.65.1 libboost-regex1.65.1 libboost-iostreams1.65.1 libcgroup1 libqt5network5 libboost-locale1.65.1 libsqlite3-0 libmpfr6 libexpat1 libxml2 libqt5sql5 \
 && rm -rf /var/lib/apt/lists/* \
 && echo '#!/bin/bash' > /usr/local/bin/autoexecute \
 && echo 'mkdir -m 777 -p /fme-shared/CoordinateSystemExceptions /fme-shared/CoordinateSystemGridOverrides /fme-shared/CoordinateSystems /fme-shared/CsmapTransformationExceptions /fme-shared/Formats /fme-shared/TransformerCategories /fme-shared/Transformers /fme-shared/Workspaces /fme-shared/AutoExecute /fme-shared/AutoExecute/Finished' >> /usr/local/bin/autoexecute \
 && echo 'while true; do executable="$(find /fme-shared/AutoExecute -type f -print -quit)"; if [ -n "$executable" ]; then echo "Executing $executable"; "$executable"; mv -f "$executable" /fme-shared/AutoExecute/Finished/; fi; sleep 1; done' >> /usr/local/bin/autoexecute \
 && useradd --create-home --shell /bin/bash $LINUX_USER \
 && chown $LINUX_USER:$LINUX_USER /usr/local/bin/autoexecute \
 && chmod u=x,go= /usr/local/bin/autoexecute \
 && mkdir -p /opt/fme /fme-shared \
 && chown -R $LINUX_USER:$LINUX_USER /fme-shared \
 && ln -s /fme-shared /home/$LINUX_USER/.fme \
 && ln -fns /usr/share/zoneinfo/$TZ /etc/localtime \
 && echo $TZ > /etc/timezone

USER $LINUX_USER
WORKDIR /fme-shared/Workspaces

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/fme" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8"

CMD ["autoexecute"]
