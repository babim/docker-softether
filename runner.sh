#!/bin/sh

if [ ! -f "/vpn/vpn_server.config" ]; then
  cp /etc-start/vpn_server.config /vpn/vpn_server.config
fi

if [ ! -d "/var/log/vpnserver/security_log" ]; then
  mkdir -p /var/log/vpnserver/security_log
fi

if [ ! -d "/var/log/vpnserver/packet_log" ]; then
  mkdir -p /var/log/vpnserver/packet_log
fi

if [ ! -d "/var/log/vpnserver/server_log" ]; then
  mkdir -p /var/log/vpnserver/server_log
fi

chmod -R 777 /var/log/vpnserver/
ln -s /var/log/vpnserver/*_log /usr/local/vpnserver/

exec /usr/local/vpnserver/vpnserver execsvc

exit $?
