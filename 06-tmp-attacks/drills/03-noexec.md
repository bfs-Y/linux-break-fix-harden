# Drill 03: Harden /tmp with noexec

**Time limit:** 5 minutes
**Environment:** Clean system. Apply hardening before an attack happens.

## Scenario

You are hardening a fresh server before deployment. /tmp has no execution
restrictions. Apply noexec and verify it works. Then test whether an
interpreter bypasses it.

## Tasks

1. Check current /tmp mount options
2. Remount /tmp with noexec,nosuid,nodev
3. Verify a binary cannot execute directly from /tmp
4. Test whether bash bypasses noexec

## Commands in Order

    mount | grep " /tmp "
    mount -o remount,noexec,nosuid,nodev /tmp
    echo "#!/bin/bash" > /tmp/test.sh && chmod +x /tmp/test.sh
    /tmp/test.sh
    bash /tmp/test.sh
    rm /tmp/test.sh

## Success Criteria

- noexec confirmed in mount output
- Direct execution blocked — permission denied
- bash /tmp/test.sh runs successfully — bypass confirmed
- Understand why noexec alone is not sufficient

## Failure Modes

- Assuming noexec stops all execution from /tmp
- Not testing the interpreter bypass
- Not verifying mount options after remount

## Solution

[Run drill first. Fill this in after at least two attempts.]
