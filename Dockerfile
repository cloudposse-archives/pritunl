FROM alpine:3.4

#------------------------------------------------------------------------------
# Environment variables:
#------------------------------------------------------------------------------

ENV VERSION="1.26.1231.99"

#------------------------------------------------------------------------------
# Install:
#------------------------------------------------------------------------------

RUN set -ex \
    && apk --no-cache add --update -t deps go git bzr wget py-pip \
    gcc python-dev musl-dev linux-headers libffi-dev openssl-dev \
    && apk --no-cache add --update py-setuptools openssl procps ca-certificates openvpn \
    && export GOPATH=/go && go get github.com/pritunl/pritunl-dns \
    && go get github.com/pritunl/pritunl-monitor \
    && go get github.com/pritunl/pritunl-web && cp /go/bin/* /usr/bin/ \
    && wget https://github.com/pritunl/pritunl/archive/${VERSION}.tar.gz \
    && tar zxvf ${VERSION}.tar.gz && cd pritunl-${VERSION} \
    && python2 setup.py build && pip install --upgrade pip \
    && pip install -r requirements.txt && mkdir -p /var/lib/pritunl \
    && python2 setup.py install && rm -rf *${VERSION}* && rm -rf /go \
    && apk del --purge deps; rm -rf /tmp/* /var/cache/apk/*

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