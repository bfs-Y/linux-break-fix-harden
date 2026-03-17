# Module 13 - File Permissions & Directory Security

## Scripts
- break.sh: Removes sticky bit from /tmp, creates world-writable dir, world-writable file in /etc, and plants a rogue SUID binary
- find.sh: Audits world-writable files, SUID/SGID binaries, unowned files, and world-writable /etc files
- fix.sh: Restores sticky bit, removes world-writable dir and file, removes rogue SUID binary
- harden.sh: Enforces sticky bit on /tmp and /var/tmp, removes unnecessary SUID from chfn and chsh, restricts world-writable files in /etc

## What surprised me
Bash scripting is multitasking — running multiple security checks at once is great for job efficiency and productivity. Understanding sticky bit, SUID, and world-writable permissions in Docker made it safe to break and fix things without fear of damaging a real system.

## Edge cases / gaps
- World-writable symlinks in /etc persist after chmod 644 — chmod hits the target not the link
- /tmp with sticky bit still appeared in world-writable output until -not -perm -1000 was added
- find2 SUID binary in /usr/local/bin — non-standard path is the red flag, not just SUID
