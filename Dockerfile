# SoftEther VPN server
FROM babim/alpinebase

ARG BUILD_PKG="tar gcc git curl expat libssh2 pcre libc-dev readline-dev zlib-dev openssl-dev ncurses-dev make"
ARG TEMP_DIR="/tmp/softethervpn"
ARG VERSION=4.22-9634-beta

LABEL description="SoftEtherVPN Server"
LABEL version="${VERSION}"

ENV LANG=en_US.UTF-8

RUN set -e \
    && apk add --no-cache ${BUILD_PKG} iptables iproute2 readline ncurses zlib \
    && mkdir -p ${TEMP_DIR} \
    && git clone --branch "v${VERSION}" --depth 1 https://github.com/SoftEtherVPN/SoftEtherVPN.git ${TEMP_DIR} \
    && cd ${TEMP_DIR} \
    && cp src/makefiles/linux_64bit.mak Makefile \
    && make \
    && make install \
    && cd - \
    && apk del --purge ${BUILD_PKG} \
    && rm -rf /var/cache/apk/* ${TEMP_DIR}

RUN mkdir -p /vpn/logvpn && rm -rf /var/log/vpnserver && ln -s /vpn/logvpn /var/log/vpnserver
RUN touch /vpn/vpn_server.config && ln -s /vpn/vpn_server.config /usr/local/vpnserver/vpn_server.config

ADD runner.sh /usr/local/vpnserver/runner.sh
RUN chmod 755 /usr/local/vpnserver/runner.sh

VOLUME /vpn
EXPOSE 1071/tcp 1194/tcp 1194/udp 443/tcp 4500/udp 500/udp 5555/tcp 992/tcp

ENTRYPOINT ["/usr/local/vpnserver/runner.sh"]
