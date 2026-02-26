# Drill 05: System Audit

Time: 10 minutes

## What You're Doing

Running security and health checks using /sbin tools.

## Start Container
```bash
docker run -it --rm --privileged ubuntu:22.04 /bin/bash
apt update && apt install -y systemd
```

## User Audit

Check for multiple root users (bad):
```bash
awk -F: '$3 == 0 {print $1}' /etc/passwd
```

Should only show "root". Others with UID 0 = backdoor accounts.

Check for users with no password:
```bash
awk -F: '$2 == "" {print $1}' /etc/shadow
```

Should be empty. No password = security hole.

List all regular users:
```bash
awk -F: '$3 >= 1000 {print $1,$3}' /etc/passwd
```

Shows users and their UIDs.

Check sudo access:
```bash
cat /etc/sudoers
cat /etc/sudoers.d/*
```

Look for dangerous rules (ALL, NOPASSWD on vim/find/etc).

## Filesystem Audit

Check disk space:
```bash
df -h
```

Over 80% = potential problem.

Find large files:
```bash
du -sh /* | sort -h
```

Shows biggest directories.

Check mounted filesystems:
```bash
mount
```

Look for:
- noexec on /tmp (good - prevents execution)
- ro on sensitive dirs (good - read-only)

Find world-writable files:
```bash
find / -type f -perm -002 2>/dev/null
```

Anyone can modify these files (usually bad).

Find files with no owner:
```bash
find / -nouser -o -nogroup 2>/dev/null
```

Orphaned files (user deleted but files remain).

## Service Audit

List running services:
```bash
systemctl list-units --type=service --state=running
```

Unknown services = investigate.

Check failed services:
```bash
systemctl list-units --type=service --state=failed
```

Failed = potential problem.

Check what's listening on network:
```bash
ss -tulpn
```

or older systems:
```bash
netstat -tulpn
```

Shows open ports. Unexpected services = red flag.

## SUID Binary Check

Find all SUID binaries:
```bash
find / -perm -4000 2>/dev/null
```

Compare to expected list. New SUID = investigate.

Check for dangerous SUID:
```bash
for cmd in vim nano find bash python; do
    find /usr -name $cmd -perm -4000 2>/dev/null
done
```

Should be empty. These shouldn't have SUID.

## Capability Check
```bash
apt install -y libcap2-bin
getcap -r / 2>/dev/null
```

Check each result. CAP_SETUID on wrong binary = backdoor.

## System Resource Check

CPU and memory:
```bash
top -bn1 | head -20
```

Shows what's using resources.

Load average:
```bash
uptime
```

High load = overworked system.

## Log Check

Recent auth attempts:
```bash
tail -50 /var/log/auth.log
```

Failed logins = potential attack.

System errors:
```bash
journalctl -p err -n 50
```

Shows recent errors.

## Create Audit Script
```bash
cat > /root/audit.sh << 'EOF'
#!/bin/bash
echo "=== System Audit ==="
echo ""
echo "Users with UID 0:"
awk -F: '$3 == 0 {print $1}' /etc/passwd
echo ""
echo "Disk Space:"
df -h | grep -v tmpfs
echo ""
echo "Failed Services:"
systemctl list-units --type=service --state=failed
echo ""
echo "SUID Binaries:"
find / -perm -4000 2>/dev/null | wc -l
echo ""
echo "World-Writable Files:"
find / -type f -perm -002 2>/dev/null | wc -l
echo ""
echo "Audit Complete"
EOF
chmod +x /root/audit.sh
```

Run it:
```bash
/root/audit.sh
```

## Exit
```bash
exit
```

## What to Look For

**Red Flags:**
- Multiple users with UID 0
- Empty passwords in /etc/shadow
- vim/find/python with SUID
- Unknown services running
- 90%+ disk usage
- Many failed logins
- Unexpected open ports

**Good Signs:**
- Only root has UID 0
- All accounts have passwords
- No dangerous SUID binaries
- Only expected services running
- Plenty of disk space
- Clean auth logs

## Key Commands Summary
```
awk -F: '$3 == 0' /etc/passwd     # Check root users
df -h                              # Disk space
find / -perm -4000                 # SUID binaries
systemctl list-units               # Services
getcap -r /                        # Capabilities
journalctl -p err                  # Error logs
```

## Key Lesson

Regular audits catch security issues before attackers do.

Combine /sbin tools for complete system picture.

Automate checks with scripts.
