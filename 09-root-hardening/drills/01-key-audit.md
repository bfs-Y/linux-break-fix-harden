# Drill 01: Audit Root SSH Keys

**Time limit:** 5 minutes
**Environment:** Live system. Audit root SSH configuration.

## Scenario

Post-breach audit. You need to determine whether root SSH keys are exposed
and whether any unauthorized keys have been added to authorized_keys.

## Tasks

1. Check permissions on /root/.ssh and all files inside it
2. List all authorized public keys
3. Check when authorized_keys was last modified
4. Verify private key is not world-readable

## Commands in Order

    ls -la /root/.ssh/
    find /root/.ssh -type f -perm /044
    cat /root/.ssh/authorized_keys 2>/dev/null
    stat /root/.ssh/authorized_keys 2>/dev/null
    stat /root/.ssh/id_rsa 2>/dev/null

## Success Criteria

- Private key confirmed as 600
- authorized_keys reviewed for unexpected entries
- Modification timestamps noted
- Any world-readable key flagged immediately

## Failure Modes

- Only checking id_rsa and missing authorized_keys
- Not checking directory permissions — 755 on .ssh exposes file list
- Not noting modification timestamps

## Solution

[Run drill first. Fill this in after at least two attempts.]
