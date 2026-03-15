# Drill 05: Timed Incident Response — Root Compromise

**Time limit:** 10 minutes
**Environment:** Full scenario. No hints.

## Scenario

Root account shows signs of compromise. SSH key may be stolen. History
may be cleared. You have 10 minutes to audit, remediate, and harden.

## Tasks

1. Audit /root/.ssh — permissions, authorized_keys, key age
2. Check bash history for signs of tampering
3. Query auditd or journalctl for surviving evidence
4. Fix any permission issues
5. Rotate SSH key if compromise confirmed
6. Apply hardening — chattr +a on history, fix sshd_config

## Pass Criteria

- All SSH files audited
- History tampering detected or ruled out
- Surviving evidence recovered from auditd or journalctl
- Permissions fixed
- Hardening applied
- Completed under 10 minutes

## Failure Modes

- Missing authorized_keys check
- Stopping at empty .bash_history without checking auditd
- Fixing permissions but not rotating the key
- Timeout

## Solution

[Run drill first. Fill this in after at least two attempts.]
