#!/bin/bash
# Make sbin binaries world-writable — dangerous misconfiguration
chmod o+w /usr/sbin/useradd
echo "useradd is now world-writable"
