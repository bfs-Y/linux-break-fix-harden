# Drill 02: Audit /dev/shm for Payloads

**Time limit:** 5 minutes
**Environment:** Live system. Suspect in-memory payload staging.

## Scenario

IDS alert fired on unusual process activity. Suspect payload was staged
in /dev/shm to avoid disk forensics. Find it.

## Tasks

1. List all files in /dev/shm including hidden files
2. Find executable files
3. Check file contents
4. Remove and verify clean

## Commands in Order

    ls -la /dev/shm/
    find /dev/shm -name ".*"
    find /dev/shm -type f -executable
    cat /dev/shm/.<suspicious file>
    find /dev/shm -type f -delete
    ls -la /dev/shm/

## Success Criteria

- Hidden files found with find -name ".*"
- Executable files identified
- Contents reviewed before deletion
- Clean /dev/shm confirmed after removal

## Failure Modes

- Running ls without -la — misses hidden files entirely
- Deleting without reading — lose evidence
- Not verifying clean state after deletion

## Solution

[Run drill first. Fill this in after at least two attempts.]
