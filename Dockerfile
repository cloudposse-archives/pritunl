FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

ENV PRITUNL_CONFIG=
ENV PRITUNL_MAIN_CONFIG=/etc/pritunl.conf

EXPOSE 9700
EXPOSE 443
EXPOSE 80
EXPOSE 1194

ENTRYPOINT ["/init"]

ENV VERSION="1.26.1231.99"

RUN set -ex \
    && apt-get update \
    && apt-get install --yes \
      apt-transport-https \
      ca-certificates \
      wget \
      python \
      openvpn \
      bridge-utils \
    && wget https://github.com/pritunl/pritunl/releases/download/${VERSION}/pritunl_${VERSION}-0ubuntu1.trusty_all.deb \
    && dpkg -i pritunl_${VERSION}-0ubuntu1.trusty_all.deb


ADD rootfs /
