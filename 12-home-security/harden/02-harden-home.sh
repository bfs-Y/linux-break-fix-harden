#!/bin/bash
echo "=== Enforcing home directory permissions ==="
for dir in /home/*/; do
    chmod 700 "$dir"
    echo "secured $dir"
done

echo "=== Enforcing .ssh permissions ==="
for sshdir in /home/*/.ssh; do
    [ -d "$sshdir" ] && chmod 700 "$sshdir"
    [ -f "$sshdir/authorized_keys" ] && chmod 600 "$sshdir/authorized_keys"
done

echo "=== Checking for suspicious .bashrc entries ==="
grep -r "dev/tcp\|/bin/bash.*>&\|nc -e\|python.*socket" /home/*/\.bashrc 2>/dev/null

echo "=== Done ==="
