# Drill 03: Defending Against SUID

Time: 7 minutes

## What You're Doing

Audit system for dangerous SUID binaries. Remove SUID from unsafe ones.

## Setup
```bash
docker run -it --rm ubuntu:22.04 /bin/bash
```

Make some binaries dangerously SUID (simulate bad config):
```bash
chmod u+s /usr/bin/find
chmod u+s /usr/bin/vim
apt update && apt install -y less
chmod u+s /usr/bin/less
```

## Find the Dangerous Ones
```bash
find / -perm -4000 2>/dev/null
```

Should show find, vim, less with SUID now.

## Check Which Are Dangerous
```bash
ls -l /usr/bin/find
ls -l /usr/bin/vim
ls -l /usr/bin/less
```

All show `-rwsr-xr-x` (SUID set).

## Remove SUID from Unsafe Binaries
```bash
chmod u-s /usr/bin/find
chmod u-s /usr/bin/vim
chmod u-s /usr/bin/less
```

The `u-s` removes the SUID bit.

## Verify Fix
```bash
ls -l /usr/bin/find
```

Should now show: `-rwxr-xr-x` (no 's', just 'x')
```bash
find / -perm -4000 2>/dev/null
```

Should only show the 8 legitimate SUID binaries (passwd, su, mount, etc).

## What Should Never Be SUID

Programs that can:
- Execute commands (find -exec, vim :!, less !)
- Run code (python, perl, awk)
- Open shells (bash, sh)
- Edit files (vim, nano)

Safe SUID programs:
- passwd (designed for it)
- su, sudo (authentication tools)
- mount, umount (filesystem tools)
- ping (needs raw sockets)

## Audit Script
```bash
cat > /root/audit-suid.sh << 'EOF'
#!/bin/bash
echo "=== Checking for dangerous SUID binaries ==="
DANGEROUS="vim nano find bash sh python perl awk less more"
for cmd in $DANGEROUS; do
    SUID=$(find /usr -name $cmd -perm -4000 2>/dev/null)
    if [ -n "$SUID" ]; then
        echo "[!] DANGEROUS: $SUID has SUID bit"
    fi
done
EOF
chmod +x /root/audit-suid.sh
/root/audit-suid.sh
```

Run this regularly to catch misconfigurations.

## Exit
```bash
exit
```

## Key Lesson

Default deny for SUID. Only allow what's absolutely necessary.

Check GTFOBins.github.io before making anything SUID.

