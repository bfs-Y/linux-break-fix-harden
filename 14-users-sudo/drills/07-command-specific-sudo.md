# Drill 07 — Command-specific and group-based sudo

Least privilege sudo — users get only the commands they need.

Individual command restriction:
echo "username ALL=(ALL) /usr/bin/passwd" >> /etc/sudoers

Group-based restriction:
groupadd secops
usermod -aG secops username
echo "%secops ALL=(ALL) /usr/bin/systemctl" >> /etc/sudoers

Verify:
grep username /etc/sudoers
grep secops /etc/sudoers
id username

Always use visudo to edit sudoers safely:
visudo            ← opens editor with syntax checking
visudo --check    ← validates current file without editing

Never use echo >> /etc/sudoers in production — syntax error locks everyone out.
