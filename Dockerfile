FROM katosys/pritunl

ENV PRITUNL_CONFIG=
ENV PRITUNL_MAIN_CONFIG=/etc/pritunl.conf

ADD rootfs /