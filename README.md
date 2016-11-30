[![](https://images.microbadger.com/badges/image/babim/softether.svg)](https://microbadger.com/images/babim/softether "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/softether.svg)](https://microbadger.com/images/babim/softether "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/softether:single.svg)](https://microbadger.com/images/babim/softether:single "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/softether:single.svg)](https://microbadger.com/images/babim/softether:single "Get your own version badge on microbadger.com")

Thanks frosquin

# Docker image for SoftEther VPN

This will deploy a fully functional [SoftEther VPN](https://www.softether.org) server as a docker image.

Available on [Docker Hub](https://registry.hub.docker.com/u/frosquin/softether/).

## Download

    docker pull babim/softether

## Run


Simplest version:

    docker run -d --net host --name softether babim/softether

With external config file:

    docker run -d --net host --name softether -v /data/vpnconfig:/vpn babim/softether

volume dir:
```
/vpn/vpn_server.config
/vpn/logvpn
create auto if empty
```
With external config file: (option 2)

    touch /etc/vpnserver/vpn_server.config
    docker run -d -v /etc/vpnserver/vpn_server.config:/usr/local/vpnserver/vpn_server.config --net host --name softether babim/softether

If you want to keep the logs in a data container:

    docker run -d --name softether-logs --volume /var/log/vpnserver busybox:latest /bin/true
    docker run -d --net host --name softether --volumes-from softether-logs babim/softether

All together now:

    touch /etc/vpnserver/vpn_server.config
    docker run -d --name softether-logs --volume /var/log/vpnserver busybox:latest /bin/true
    docker run -d -v /etc/vpnserver/vpn_server.config:/usr/local/vpnserver/vpn_server.config --volumes-from softether-logs --net host --name softether babim/softether

