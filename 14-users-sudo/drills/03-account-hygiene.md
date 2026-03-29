# Drill 03 — Account hygiene

Find accounts that should not exist or have shell access.

Commands:
grep -v nologin /etc/passwd | grep -v false
awk -F: '($3 == 0)' /etc/passwd
awk -F: '($2 == "")' /etc/shadow

Fix — delete account and home directory:
userdel -r username

Risk: leftover accounts are attack surface even without sudo access.
