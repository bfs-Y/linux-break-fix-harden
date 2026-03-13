#!/bin/bash
# FIX: Detect and remove symlink attack persistence

# Step 1 — check /tmp for symlinks pointing outside /tmp
echo "[DETECT] symlinks in /tmp:"
find /tmp -maxdepth 1 -type l -ls

# Step 2 — check /etc/cron.d for unexpected files
echo "[DETECT] /etc/cron.d contents:"
ls -la /etc/cron.d/
cat /etc/cron.d/backdoor 2>/dev/null && echo "[IOC] backdoor cron entry found"

# Step 3 — remove backdoor cron entry
rm -f /etc/cron.d/backdoor
echo "[FIX] backdoor removed"

# Step 4 — remove symlink
rm -f /tmp/report.txt
echo "[FIX] symlink removed"

# Step 5 — verify clean
echo "[VERIFY] /etc/cron.d:"
ls -la /etc/cron.d/

echo "[VERIFY] waiting for cron cycle"
rm -f /tmp/pwned.txt
sleep 65
cat /tmp/pwned.txt 2>/dev/null || echo "[CLEAN] no PWNED output — attack removed"
