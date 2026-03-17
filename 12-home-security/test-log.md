# Test Log - Module 12

## Baseline on clean Ubuntu 22.04 container
- /home/testuser: 750 by default — group can read, should be 700
- .bashrc: 644 world-readable but not writable — acceptable
- .ssh: does not exist by default

## Breaks planted
- chmod 755 /home/testuser — world-accessible
- chmod 666 /home/testuser/.bashrc — world-writable
- reverse shell injected into .bashrc
- attacker SSH key planted in authorized_keys

## What surprised me
Fixing authorized_keys permissions to 600 does not remove the attacker key inside — the file is secured but the backdoor remains active.

## Edge cases
- fix.sh hardcoded to testuser — real systems need user loop
- grep pattern must target specific reverse shell patterns not broad keywords
- authorized_keys must be wiped not just permission-fixed
