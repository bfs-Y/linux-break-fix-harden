# Drill 01: Finding SUID Binaries

Time: 5 minutes

## What You're Doing

You got user access to a system. Now you're hunting for ways to become root.

## Start Container
```bash
docker run -it --rm ubuntu:22.04 /bin/bash
```

## Find Everything with SUID
```bash
find / -perm -4000 2>/dev/null
```

This searches the entire system for files with the SUID bit.

On Ubuntu 22.04, you get 8 results.

## Look at One
```bash
ls -l /usr/bin/passwd
```

Shows:
```
-rwsr-xr-x 1 root root 59976
```

That 's' means SUID. This runs as root no matter who executes it.

## Count How Many
```bash
find / -perm -4000 2>/dev/null | wc -l
```

Returns: 8

## What These Binaries Do

The 8 you found are supposed to be SUID (safe):
- passwd - changes passwords in /etc/shadow
- su - switches to other users
- mount, umount - mounts disks
- chsh, chfn - edits user info
- newgrp, gpasswd - manages groups

## What Would Be Bad

If you found these with SUID root, you'd own the box:
- vim - edit any file, or `:!bash` for root shell
- find - use -exec to run commands as root
- bash, sh - instant root shell
- python, perl - run any code as root

## The One Command That Matters
```bash
find / -perm -4000 2>/dev/null
```

First thing you run when hunting for privilege escalation.

Exit when done:
```bash
exit
```
