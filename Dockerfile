FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

ENV PRITUNL_CONFIG=
ENV PRITUNL_MAIN_CONFIG=/etc/pritunl.conf

EXPOSE 9700
EXPOSE 443
EXPOSE 80
EXPOSE 1194

ENTRYPOINT ["/init"]

ENV VERSION="1.29.1979.98"

RUN echo "deb http://repo.pritunl.com/stable/apt xenial main" >> /etc/apt/sources.list.d/pritunl.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A

RUN set -ex \
    && apt-get update \
    && apt-get install --yes \
      apt-transport-https \
      ca-certificates \
      wget \
      python \
      openvpn \
      bridge-utils \
      pritunl

ADD rootfs /
