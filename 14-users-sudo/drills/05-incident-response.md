# Drill 05 — Incident response scenario

You suspect a user has been granted unauthorized sudo access. Run in order:

1. grep NOPASSWD /etc/sudoers /etc/sudoers.d/* 2>/dev/null
2. grep -v "^#" /etc/sudoers | grep -v "^$"
3. getent group sudo
4. getent group admin
5. awk -F: '($3 == 0)' /etc/passwd
6. awk -F: '($2 == "")' /etc/shadow

Target: identify all privilege misconfigs in under 3 minutes.
