# Module 13 - File Permissions & Directory Security

## Scripts
- break.sh: Plants four permission misconfigs — removes sticky bit from /tmp, creates world-writable dir, world-writable file in /etc, and rogue SUID binary
- find.sh: Audits the system for world-writable files, SUID/SGID binaries, unowned files, and world-writable /etc files
- fix.sh: Reverses all four breaks — restores sticky bit, removes bad dir/file, removes rogue SUID binary
- harden.sh: Goes beyond fix — enforces sticky bit on /tmp and /var/tmp, removes unnecessary SUID from chfn and chsh, restricts world-writable files in /etc

## What surprised me
Bash scripting handles multiple security checks at once in a single run. Also how sticky bit, SUID, and world-writable permissions connect directly to real attack paths. Running this in Docker made it safe to break things without fear.

## Edge cases I would have missed under pressure
- World-writable entries in /etc are symlinks — chmod hits the target not the link, so find.sh keeps reporting them.
- /tmp with sticky bit still appeared in world-writable output until -not -perm -1000 was added to filter it.
