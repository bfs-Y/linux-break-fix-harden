#!/bin/bash
echo "=== SUID binaries ==="
find / -perm -4000 -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null

echo "=== SGID binaries ==="
find / -perm -2000 -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null

echo "=== SUID outside /usr/bin ==="
find / -perm -4000 -not -path "/usr/bin/*" -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null
