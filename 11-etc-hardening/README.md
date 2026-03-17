# Module 11 - /etc Hardening

## What this covers
- /etc/passwd and /etc/shadow permission hardening
- Backdoor account detection and removal
- UID 0 account auditing
- Empty password hash detection

## Attack paths
- World-readable /etc/shadow: password hashes exposed, offline cracking possible
- World-writable /etc/passwd: any user can add a root account
- Backdoor UID 0 account with empty hash: root access with no password required

## Scripts
- break/01-etc-misconfig.sh: plants four misconfigs
- fix/01-fix-etc.sh: reverses all breaks
- harden/01-audit-etc.sh: finds all four vulnerability categories
- harden/02-harden-etc.sh: enforces secure baseline
