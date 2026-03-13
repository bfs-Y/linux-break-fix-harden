# Drill 02: Remove Cron PATH Hijack

**Time limit:** 5 minutes
**Environment:** Confirmed compromise. Malicious ls in /tmp firing every minute.

## Scenario

Attack is confirmed. /tmp/ls is executing as root via cron. You need to
stop it and fix the root cause — not just the symptom.

## Tasks

1. Remove the malicious binary
2. Fix the crontab PATH — remove /tmp from it
3. Verify ls resolves to the real binary
4. Confirm cron fires clean on next execution

## Commands in Order

    rm /tmp/ls
    crontab -e  (remove /tmp from PATH line)
    which ls
    sleep 65 && cat /tmp/cron-output.txt

## Success Criteria

- /tmp/ls removed
- /tmp no longer in crontab PATH
- which ls returns /usr/bin/ls
- No PWNED output in next cron execution

## Failure Modes

- Removing the binary but not fixing the PATH — next attacker does the same
- Not verifying cron fires clean after fix
- Fixing the PATH but leaving the binary

## Solution

[Run drill first. Fill this in after at least two attempts.]
