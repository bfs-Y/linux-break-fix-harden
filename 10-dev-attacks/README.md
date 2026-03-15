# /dev Attacks

/dev is not just hardware. It is an interface to the kernel itself. /dev/null,
/dev/shm, /dev/mem, /dev/ptrace — these are not files in the traditional sense.
They are entry points into system behavior. Tamper with them and you change how
the OS works, not just what's on disk.

Most defenders never audit /dev. That's why attackers like it.

## Threat Model

/dev/null replacement is quiet. Scripts that discard sensitive output suddenly
capture it instead. The script keeps running normally. Nothing breaks. The
attacker just reads the file later.

/dev/shm is RAM. Files there leave minimal forensic trace. Combined with
interpreter bypass of noexec, it becomes a staging ground that survives
reboots only while the system is up — which is exactly long enough.

## What Was Tested

- /dev/null replacement with a capture file
- Detection via character device type check
- Restoration using mknod with correct major/minor numbers
- /dev/shm payload staging and execution via interpreter bypass
- Detection of hidden files and executables in /dev/shm

## Break 01: /dev/null Replacement

Replaced the character device with a regular file. Every subsequent write
to /dev/null landed in the file instead of being discarded. Passwords and
API keys meant to disappear were captured.

Detection — one command:

    ls -la /dev/null

Legitimate: crw-rw-rw- with 1, 3 device numbers.
Replaced: -rw-rw-rw- regular file, no device numbers.

The c at the start is the only thing that matters.

## Break 02: /dev/shm Payload

Staged executable in /dev/shm. Direct execution blocked by noexec mount
option. Bypassed immediately with bash interpreter. Payload ran as root
with no disk write outside of /dev/shm itself.

Detection:

    ls -la /dev/shm/
    find /dev/shm -name ".*"
    find /dev/shm -type f -executable

Hidden files start with dot — ls without -la misses them entirely.

## Fix

Restore /dev/null:

    rm /dev/null
    mknod -m 666 /dev/null c 1 3

Verify by echoing to it and confirming cat returns nothing.

Clear /dev/shm:

    find /dev/shm -type f -delete
    ls -la /dev/shm/

## Harden

    # Make /dev/null immutable
    chattr +i /dev/null

    # Verify /dev/shm has noexec
    mount | grep shm

    # Monitor for new files in /dev/shm
    find /dev/shm -type f -newer /proc/1/exe

noexec on /dev/shm does not stop interpreter bypass. Real protection
requires auditd rules watching for process execution from /dev/shm paths.

## Failure Modes

- Not checking /dev/null type — size 0 looks clean, only type reveals tampering
- Running ls /dev/shm without -la — hidden files invisible
- Assuming noexec stops all execution from /dev/shm
- Not monitoring /dev/shm — files there leave minimal trace after deletion
- Forgetting mknod major/minor numbers — 1,3 for /dev/null

## Next

Consolidation — run all 10 module drills before moving to active defense
tooling: auditd rules, AIDE integrity monitoring, and incident response
playbooks.
