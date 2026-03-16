#!/bin/bash
chmod 1777 /tmp
chmod 1777 /var/tmp
chmod u-s /usr/bin/chfn
chmod u-s /usr/bin/chsh
find /etc -type f -perm -002 -exec chmod 644 {} \;
