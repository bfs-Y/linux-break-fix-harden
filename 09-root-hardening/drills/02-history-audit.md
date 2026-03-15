# Drill 02: Detect History Tampering

**Time limit:** 5 minutes
**Environment:** Post-breach system. History may have been cleared.

## Scenario

You suspect the attacker cleared bash history before leaving. Determine
what you can still recover and where to look for surviving evidence.

## Tasks

1. Check current bash history
2. Check HISTFILE and HISTSIZE values
3. Query auditd for executed commands
4. Check journalctl for session activity

## Commands in Order

    cat /root/.bash_history
    echo $HISTFILE
    echo $HISTSIZE
    ausearch -m EXECVE 2>/dev/null | tail -20
    journalctl _UID=0 --no-pager | tail -20

## Success Criteria

- History file contents noted — empty means tampering likely
- HISTFILE and HISTSIZE confirmed active
- auditd or journalctl queried for surviving evidence
- Understand why kernel-level logging survives history clearing

## Failure Modes

- Giving up after finding empty .bash_history
- Not checking auditd — it records at kernel level regardless of HISTFILE
- Not checking journalctl for session boundaries

## Solution

[Run drill first. Fill this in after at least two attempts.]
