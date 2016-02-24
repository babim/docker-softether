#!/bin/sh

[[ -f /vpn/vpn_server.config ]] || touch /vpn/vpn_server.config

[[ -d /var/log/vpnserver/security_log ]] || mkdir -p /var/log/vpnserver/security_log
[[ -d /var/log/vpnserver/packet_log ]] || mkdir -p /var/log/vpnserver/packet_log
[[ -d /var/log/vpnserver/server_log ]] || mkdir -p /var/log/vpnserver/server_log

chmod -R 777 /var/log/vpnserver/
ln -s /var/log/vpnserver/*_log /usr/local/vpnserver/

exec /usr/local/vpnserver/vpnserver execsvc

exit $?
