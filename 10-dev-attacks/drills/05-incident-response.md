# Drill 05: Timed Incident Response — /dev Attack

**Time limit:** 10 minutes
**Environment:** Full scenario. No hints.

## Scenario

Alert fires. Suspicious process activity. Sensitive data appearing where
it should not. You suspect /dev tampering. Find it, fix it, harden it.

## Tasks

1. Check /dev/null integrity
2. Audit /dev/shm for payloads
3. Restore /dev/null if tampered
4. Clear /dev/shm
5. Apply hardening — chattr +i on /dev/null
6. Document findings in test-log.md

## Pass Criteria

- /dev/null type verified or restored
- /dev/shm fully audited including hidden files
- Both locations clean after remediation
- Hardening applied
- Completed under 10 minutes

## Failure Modes

- Missing hidden files in /dev/shm
- Not verifying /dev/null discard behavior after restoration
- Forgetting mknod parameters
- Timeout

## Solution

[Run drill first. Fill this in after at least two attempts.]
