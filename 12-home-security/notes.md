# Module 12 - /home Security

## Scripts
- break.sh: Opens home directory to all users, makes .bashrc world-writable, injects a reverse shell, and plants an attacker SSH key
- find.sh: Audits home directory permissions, finds world-writable dotfiles, checks .ssh permissions, and detects reverse shells in .bashrc
- fix.sh: Locks down home directory to 700, removes reverse shell from .bashrc, fixes .ssh permissions, wipes authorized_keys content
- harden.sh: Enforces 700 on all home directories and 600 on all authorized_keys files across all users

## What surprised me
The attacker key in authorized_keys survives a permissions fix — locking down the file to 600 does not remove the key inside it. You can secure the file and still be fully compromised.

## Edge cases / gaps
- fix.sh is hardcoded to testuser — on a real system you need to loop over all users
- grep pattern for suspicious .bashrc was too broad initially — matched legitimate lines like alias definitions
- authorized_keys must be emptied not just permission-fixed
