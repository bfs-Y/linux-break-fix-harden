# Drill 03: Demonstrate and Defend noexec Bypass

**Time limit:** 5 minutes
**Environment:** /dev/shm mounted with noexec.

## Scenario

A colleague says noexec on /dev/shm makes it safe. Prove them wrong,
then explain what real protection looks like.

## Tasks

1. Confirm noexec is set on /dev/shm
2. Drop a script in /dev/shm and try direct execution — fails
3. Execute via bash interpreter — succeeds
4. Explain what auditd rule would catch this

## Commands in Order

    mount | grep shm
    echo '#!/bin/bash' > /dev/shm/test.sh && chmod +x /dev/shm/test.sh
    /dev/shm/test.sh
    bash /dev/shm/test.sh
    rm /dev/shm/test.sh

## Success Criteria

- noexec confirmed in mount output
- Direct execution blocked — permission denied
- Interpreter bypass succeeds
- Can explain auditd rule needed to detect it

## Failure Modes

- Assuming noexec is sufficient protection
- Not testing interpreter bypass
- Not cleaning up test file

## Solution

[Run drill first. Fill this in after at least two attempts.]
