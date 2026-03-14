# Drill 01: Detect Log Tampering

**Time limit:** 5 minutes
**Environment:** Live system. Auth log looks suspicious.

## Scenario

You are reviewing a server after a suspected breach. auth.log has a sudo
entry but no preceding SSH login. Confirm tampering and find what is missing.

## Tasks

1. Check auth.log for gaps in login sequence
2. Compare with journald for missing entries
3. Check log file metadata for suspicious modification time
4. Confirm the IOC — sudo with no login

## Commands in Order

    cat /var/log/auth.log
    grep "sshd" /var/log/auth.log
    grep "sudo" /var/log/auth.log
    ls -la /var/log/auth.log
    journalctl _COMM=sshd --no-pager | tail -20

## Success Criteria

- Gap identified between login and sudo entries
- Modification time noted as suspicious
- journald queried for missing entries
- IOC documented

## Failure Modes

- Trusting local logs without cross-referencing journald
- Missing the sudo-without-login pattern
- Not checking file metadata

## Solution

[Run drill first. Fill this in after at least two attempts.]
