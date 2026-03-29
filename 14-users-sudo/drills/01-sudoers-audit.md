# Drill 01 — Sudoers audit

Read /etc/sudoers and find all active rules. Never edit directly — use visudo.

Commands:
grep -v "^#" /etc/sudoers | grep -v "^$"
grep NOPASSWD /etc/sudoers /etc/sudoers.d/* 2>/dev/null

Red flags:
- NOPASSWD:ALL on any account
- Unknown usernames with sudo access
- Entries in /etc/sudoers.d/ you did not create
