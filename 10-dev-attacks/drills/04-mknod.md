# Drill 04: Restore /dev/null From Memory

**Time limit:** 3 minutes
**Environment:** /dev/null has been replaced with a regular file.

## Scenario

You confirmed /dev/null is tampered. Restore it correctly from memory.
No notes. No Googling.

## Tasks

1. Remove the fake /dev/null
2. Recreate the character device with correct parameters
3. Verify correct type and device numbers
4. Confirm data is discarded

## Commands in Order

    rm /dev/null
    mknod -m 666 /dev/null c 1 3
    ls -la /dev/null
    echo "test" > /dev/null
    cat /dev/null

## Success Criteria

- crw-rw-rw- confirmed in ls output
- Device numbers 1, 3 confirmed
- cat /dev/null returns nothing
- Completed from memory under 3 minutes

## Failure Modes

- Wrong major or minor number
- Forgetting -m 666 — permissions too restrictive
- Not verifying after restoration

## Solution

[Run drill first. Fill this in after at least two attempts.]
