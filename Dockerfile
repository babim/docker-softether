# SoftEther VPN server
FROM babim/debianbase

ENV VERSION v4.21-9613-beta-2016.04.24
WORKDIR /usr/vpnserver

RUN apt-get update &&\
        apt-get -y -q install iptables gcc make wget && \
        apt-get clean && \
        rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
        wget http://www.softether-download.com/files/softether/${VERSION}-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-${VERSION}-linux-x64-64bit.tar.gz -O /tmp/softether-vpnserver.tar.gz &&\
        tar -xzvf /tmp/softether-vpnserver.tar.gz -C /usr/ &&\
        rm /tmp/softether-vpnserver.tar.gz &&\
        make i_read_and_agree_the_license_agreement &&\
        apt-get purge -y -q --auto-remove gcc make wget

RUN mkdir -p /vpn/logvpn && rm -rf /var/log/vpnserver && ln -s /vpn/logvpn /var/log/vpnserver
RUN touch /vpn/vpn_server.config && ln -s /vpn/vpn_server.config /usr/vpnserver/vpn_server.config

ADD runner.sh /usr/vpnserver/runner.sh
RUN chmod 755 /usr/vpnserver/runner.sh

VOLUME /vpn
EXPOSE 443/tcp 992/tcp 1194/tcp 1194/udp 5555/tcp 500/udp 4500/udp

ENTRYPOINT ["/usr/vpnserver/runner.sh"]
