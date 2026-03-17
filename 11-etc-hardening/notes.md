# Module 11 - /etc Hardening

## Scripts
- break.sh: Misconfigures /etc/shadow to world-readable, /etc/passwd to world-writable, and injects a backdoor UID 0 account with empty password
- find.sh: Audits shadow and passwd permissions, detects rogue UID 0 accounts, and finds empty password hashes
- fix.sh: Restores correct permissions on shadow and passwd, removes backdoor entries from both files
- harden.sh: Enforces correct permissions on passwd, shadow, group and gshadow, alerts on rogue UID 0 accounts and empty hashes

## What surprised me
A backdoor account with UID 0 and empty password hash requires no root password to login — a Linux user would assume root access requires a password but it doesnt. The system hands over root silently.

## Edge cases / gaps
- harden.sh reports rogue UID 0 accounts but does not remove them — in a real hardening script it should also delete or lock the account
- find.sh must be run as root to read /etc/shadow — running as a normal user returns permission denied and misses empty hash findings
