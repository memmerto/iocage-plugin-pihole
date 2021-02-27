#!/bin/sh

: ${pihole_data="/var/db/pihole"}
: ${pihole_log="/var/log/pihole.log"}
: ${pihole_listen="0.0.0.0,::"}

# Enable the service
sysrc -f /etc/rc.conf pihole_args="--configdir=${pihole_data} --logfile=${pihole_log} --listen=${pihole_listen} --ssl-cert=${pihole_data}/quasselCert.pem --require-ssl"
sysrc -f /etc/rc.conf pihole_enable="YES"

# Make the default DB dir
mkdir -p /var/db/pihole
chown pihole:pihole /var/db/pihole

# Gen the SSL key
printf "\n\n\n\n\n\n\n\n\n\n" | /usr/local/etc/rc.d/pihole onekeygen 2>/dev/null >/dev/null

# Start the service
if $(service pihole start 2>/dev/null >/dev/null) ; then
    echo "Starting pihole."
fi
