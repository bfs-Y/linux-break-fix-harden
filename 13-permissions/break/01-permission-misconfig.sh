#!/bin/bash
chmod o-t /tmp
mkdir -p /opt/shared
chmod 777 /opt/shared
touch /etc/badconfig
chmod 666 /etc/badconfig
cp /usr/bin/find /usr/local/bin/find2
chmod u+s /usr/local/bin/find2
