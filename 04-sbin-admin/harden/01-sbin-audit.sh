#!/bin/bash
echo "=== World-writable sbin binaries ==="
find /usr/sbin /sbin -perm -o+w 2>/dev/null

echo "=== SUID binaries in sbin ==="
find /usr/sbin /sbin -perm -4000 2>/dev/null

echo "=== Unexpected files in sbin ==="
find /usr/sbin /sbin -not -user root 2>/dev/null
