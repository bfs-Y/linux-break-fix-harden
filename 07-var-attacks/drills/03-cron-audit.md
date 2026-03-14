# Drill 03: Audit Cron Persistence

**Time limit:** 5 minutes
**Environment:** Post-compromise system. Suspect cron persistence.

## Scenario

You inherit a system after a breach. You need to find any cron-based
persistence planted by the attacker across all users and system locations.

## Tasks

1. Check current user crontab
2. Check /var/spool/cron/crontabs for all users
3. Check /etc/cron.d for system-wide entries
4. Check /etc/crontab

## Commands in Order

    crontab -l
    ls -la /var/spool/cron/crontabs/
    cat /var/spool/cron/crontabs/*
    ls -la /etc/cron.d/
    cat /etc/cron.d/*
    cat /etc/crontab

## Success Criteria

- All four cron locations checked
- Any unexpected entries flagged
- Difference between /var/spool/cron and /etc/cron.d understood

## Failure Modes

- Only checking crontab -l — misses other users and system cron
- Missing /etc/cron.d entirely
- Not reading the actual file contents

## Solution

[Run drill first. Fill this in after at least two attempts.]
