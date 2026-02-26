# Privilege Escalation - SUID & Capabilities

How regular users become root by exploiting misconfigured programs.

## The Problem

Some programs need root to work. passwd needs to edit /etc/shadow. ping needs raw network access.

Linux solves this with the SUID bit. The program runs as its owner (root) instead of as you.

When these programs have bugs or poor design, attackers use them to get root shells.

## What We're Testing

- Finding SUID binaries on a system
- Figuring out which ones are exploitable
- Using them to get root
- How to prevent this

## SUID Basics

Normal program:
```
-rwxr-xr-x  user:user  /home/user/script.sh
```
Runs with your permissions.

SUID program:
```
-rwsr-xr-x  root:root  /usr/bin/passwd
```
That 's' instead of 'x' means it runs as root no matter who executes it.

## Common SUID Binaries

Safe (supposed to be SUID):
- passwd, sudo, su
- ping, mount, umount

Dangerous (should NOT be SUID):
- vim, find, bash, python, perl
- tar, zip, docker
- Anything that lets you run commands

If you find vim with SUID root, you can get a root shell.

## Finding Them
```bash
find / -perm -4000 2>/dev/null
```

Shows every SUID binary on the system.
```bash
ls -l /usr/bin/vim
```

Check if it's owned by root and has the 's' bit.

## Attack Scenario

You're a regular user. You find /usr/bin/vim is SUID root.

You run: `vim -c ':!bash'`

You now have root shell. Game over.

## What We're NOT Covering

- Kernel exploits (different topic)
- Network attacks
- Physical access
- Container breakouts (needs separate module)

Focus here is SUID binaries and capabilities only.
