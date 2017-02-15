FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yq && \
    apt-get install -yq software-properties-common python-software-properties && \
    add-apt-repository -y ppa:pritunl/ppa && \
    apt-get update -yq && \
    apt-get install -yq pritunl && \
    apt-get clean -y && \
    apt-get autoremove -y

#------------------------------------------------------------------------------
# Populate root file system:
#------------------------------------------------------------------------------

ADD rootfs /

#------------------------------------------------------------------------------
# Expose ports and entrypoint:
#------------------------------------------------------------------------------

ENV PRITUNL_CONFIG=
ENV PRITUNL_MAIN_CONFIG=/etc/pritunl.conf

EXPOSE 9700
EXPOSE 443
EXPOSE 80
EXPOSE 1194

ENTRYPOINT ["/init"]