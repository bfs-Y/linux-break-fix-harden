#!/bin/bash
echo "=== Enforcing /etc file permissions ==="
chmod 644 /etc/passwd
chmod 640 /etc/shadow
chmod 644 /etc/group
chmod 640 /etc/gshadow
echo "=== Checking for rogue UID 0 accounts ==="
awk -F: '($3 == 0 && $1 != "root")' /etc/passwd
echo "=== Checking for empty password hashes ==="
awk -F: '($2 == "")' /etc/shadow
echo "=== Done ==="
