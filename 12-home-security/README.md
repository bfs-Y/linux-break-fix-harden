# Module 12 - /home Security

## What this covers
- Home directory permission hardening
- Dotfile persistence detection
- SSH authorized_keys auditing
- Reverse shell detection in shell startup files

## Attack paths
- World-accessible home directory: exposes all user files to other local users
- World-writable .bashrc: attacker injects reverse shell that runs on every login
- Attacker key in authorized_keys: permanent SSH access survives password changes
- .ssh directory world-readable: exposes key material

## Scripts
- break/01-home-misconfig.sh: plants four misconfigs
- fix/01-fix-home.sh: reverses all breaks
- harden/01-audit-home.sh: finds all vulnerability categories
- harden/02-harden-home.sh: enforces secure baseline across all users
