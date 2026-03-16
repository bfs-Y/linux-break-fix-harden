#!/bin/bash
echo "=== World-writable files/dirs (no sticky bit) ==="
find / -perm -o+w -not -perm -1000 \
  -not -path "/proc/*" -not -path "/sys/*" -not -path "/dev/*" \
  2>/dev/null

echo "=== SUID/SGID binaries ==="
find / -perm -4000 -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null

echo "=== Files owned by nobody/nogroup ==="
find / -nouser -o -nogroup 2>/dev/null

echo "=== World-writable files in /etc ==="
find /etc -perm -o+w 2>/dev/null
