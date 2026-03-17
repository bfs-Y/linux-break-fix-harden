#!/bin/bash
echo "=== Shadow file permissions ==="
ls -la /etc/shadow

echo "=== Passwd file permissions ==="
ls -la /etc/passwd

echo "=== UID 0 accounts ==="
awk -F: '($3 == 0)' /etc/passwd

echo "=== Empty password hashes ==="
awk -F: '($2 == "")' /etc/shadow
