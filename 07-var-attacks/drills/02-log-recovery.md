# Drill 02: Respond to Truncated Auth Log

**Time limit:** 5 minutes
**Environment:** auth.log is empty. System was running for weeks.

## Scenario

You SSH into a server. auth.log exists but is zero bytes. The system has
been running for three weeks. Find out what happened and recover what you can.

## Tasks

1. Confirm auth.log is empty
2. Check journald for auth events that predate the truncation
3. Check if logrotate created a backup
4. Document what is unrecoverable

## Commands in Order

    ls -la /var/log/auth.log
    stat /var/log/auth.log
    journalctl _COMM=sshd --no-pager | tail -30
    ls -la /var/log/auth.log*
    ls -la /var/log/auth.log.1 2>/dev/null

## Success Criteria

- Empty file confirmed with stat
- journald queried for surviving entries
- Logrotate backups checked
- Understand what was lost and what survived

## Failure Modes

- Assuming all evidence is gone without checking journald
- Not checking logrotate backups
- Not documenting the gap for incident report

## Solution

[Run drill first. Fill this in after at least two attempts.]
