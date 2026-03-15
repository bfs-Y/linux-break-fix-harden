# Drill 01: Detect Tampered /dev/null

**Time limit:** 3 minutes
**Environment:** Live system. /dev/null may have been replaced.

## Scenario

Post-compromise audit. Scripts have been redirecting sensitive output to
/dev/null. Verify it is legitimate before trusting any discarded output.

## Tasks

1. Check /dev/null type — character device or regular file
2. Verify major and minor device numbers
3. Test that data written to it is actually discarded
4. Restore if tampered

## Commands in Order

    ls -la /dev/null
    stat /dev/null
    echo "test" > /dev/null && cat /dev/null
    # if tampered:
    rm /dev/null && mknod -m 666 /dev/null c 1 3

## Success Criteria

- Character device confirmed — c at start of ls output
- Device numbers 1, 3 confirmed
- echo test produces no cat output
- Can restore from memory without notes

## Failure Modes

- Only checking file size — size 0 looks clean even when replaced
- Not testing discard behavior after visual check
- Forgetting mknod syntax for restoration

## Solution

[Run drill first. Fill this in after at least two attempts.]
