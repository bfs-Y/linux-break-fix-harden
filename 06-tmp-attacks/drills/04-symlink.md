# Drill 04: Understand Symlink Attack Surface in /tmp

**Time limit:** 8 minutes
**Environment:** Any system with /tmp write access.

## Scenario

A privileged script runs every minute and writes output to /tmp/report.txt.
You are a low-privilege user. Demonstrate how a symlink attack would redirect
that write to a sensitive file.

## Tasks

1. Create a symlink at /tmp/report.txt pointing at /tmp/redirected.txt
2. Trigger the privileged write
3. Confirm the write landed in the symlink target
4. Understand what the target could be in a real attack

## Commands in Order

    ln -s /tmp/redirected.txt /tmp/report.txt
    echo "privileged output" > /tmp/report.txt
    cat /tmp/redirected.txt
    ls -la /tmp/report.txt

## Success Criteria

- Symlink created successfully
- Write redirected to symlink target
- ls -la shows report.txt is a symlink not a regular file
- Can explain what /etc/sudoers or /etc/passwd as target would mean

## Failure Modes

- Creating a regular file instead of a symlink
- Not confirming where the write actually landed
- Not understanding the real-world implication

## Solution

[Run drill first. Fill this in after at least two attempts.]
