#!/bin/bash
# Restore correct permissions on sbin binaries
chmod o-w /usr/sbin/useradd
echo "useradd permissions restored"
ls -la /usr/sbin/useradd
