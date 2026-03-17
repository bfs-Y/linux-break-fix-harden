#!/bin/bash
# Remove rogue SUID binary
rm -f /tmp/rootkit
echo "rogue SUID removed"
# Audit remaining SUID binaries
find / -perm -4000 -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null
