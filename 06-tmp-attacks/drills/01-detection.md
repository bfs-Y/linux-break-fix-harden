# Drill 01: Detect Cron PATH Hijack via /tmp

**Time limit:** 5 minutes
**Environment:** Live system. Root cron job behaving strangely.

## Scenario

You get paged. Someone says root cron output looks wrong — unexpected text
printing every minute. You SSH in. No context, no runbook.

## Tasks

1. Check /tmp for unexpected executables
2. Check crontab for /tmp in PATH
3. Identify the malicious binary
4. Confirm it is executing as root

## Commands in Order

    ls -la /tmp/
    crontab -l
    cat /tmp/<suspicious binary>
    cat /tmp/cron-output.txt

## Success Criteria

- Malicious binary found in /tmp
- /tmp identified in crontab PATH
- Binary content confirmed as attacker-controlled
- Root execution confirmed in cron output

## Failure Modes

- Checking /var/log first instead of /tmp and crontab
- Missing the PATH line in crontab
- Not reading the binary contents

## Solution

[Run drill first. Fill this in after at least two attempts.]
