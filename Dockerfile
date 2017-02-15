FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN set -ex \
    && apt-get update \
    && apt-get install apt-transport-https  --yes \
    && echo "deb https://repo.pritunl.com/stable/apt trusty main" > /etc/apt/sources.list.d/pritunl.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 42F3E95A2C4F08279C4960ADD68FA50FEA312927 \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A \
    && apt-get update \
    && apt-get install pritunl --yes

ADD rootfs /

ENV PRITUNL_CONFIG=
ENV PRITUNL_MAIN_CONFIG=/etc/pritunl.conf

EXPOSE 9700
EXPOSE 443
EXPOSE 80
EXPOSE 1194

ENTRYPOINT ["/init"]