#!/bin/bash
echo "=== Home directory permissions ==="
ls -la /home/

echo "=== World-writable dotfiles ==="
find /home -name ".*" -perm -o+w 2>/dev/null

echo "=== SSH directory permissions ==="
find /home -name ".ssh" -exec ls -la {} \; 2>/dev/null

echo "=== Suspicious .bashrc entries ==="
grep -r "dev/tcp\|/bin/bash.*>&\|nc -e\|python.*socket" /home/*/\.bashrc 2>/dev/null

echo "=== authorized_keys contents ==="
find /home -name "authorized_keys" -exec cat {} \; 2>/dev/null
