# Drill 05: Timed Incident Response — /var Attack

**Time limit:** 10 minutes
**Environment:** Full scenario. No hints.

## Scenario

Alert fires. Suspected breach on a production server. You SSH in. Find all
evidence of compromise in /var, document it, and remediate. No notes.

## Tasks

1. Check auth.log for tampering indicators
2. Cross-reference with journald
3. Audit all cron locations for persistence
4. Remove any malicious cron entries
5. Apply chattr +a to auth.log
6. Document findings in test-log.md

## Pass Criteria

- All four cron locations checked
- Log tampering IOC identified if present
- Malicious cron entries removed
- chattr +a applied to auth.log
- Completed under 10 minutes

## Failure Modes

- Missing any of the four cron locations
- Trusting local logs without journald check
- Not applying hardening after remediation
- Timeout

## Solution

[Run drill first. Fill this in after at least two attempts.]
