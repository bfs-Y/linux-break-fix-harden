# /usr Command Execution & Trust Chain

Tested how shells resolve commands. Exploited the trust model. Restored it without restart.

## Threat Model

Attacker writes malicious binary to writable directory in PATH.  
Shell uses cached hash table. Executes attacker binary instead of legitimate command.  
User doesn't notice until compromise spreads.

## What Was Tested

- PATH resolution order and hash caching behavior
- execve() calls during command execution
- Detection of foreign binaries without execution
- Trust restoration under active compromise

## Break: PATH Hijacking

Created fake `ls` binary in `/tmp`. Added `/tmp` to front of PATH.  
Shell cached the malicious path. Executed attacker code on every `ls` invocation.

Verification:
```bash
strace -e execve ls 2>&1 | grep execve
# Shows /tmp/ls executed instead of /usr/bin/ls
```

## Fix: Detection Without Execution
```bash
type -a ls        # Shows all PATH matches
hash -t ls        # Shows cached resolution
which -a ls       # Alternative verification
stat /usr/bin/ls  # Verify legitimate binary exists
```

Ground truth:
```bash
strace -e execve ls 2>&1 | grep execve
# Only way to see actual syscall
```

## Harden: Trust Restoration
```bash
hash -r           # Flush hash table
hash -t ls        # Verify new resolution
export PATH=/usr/bin:/bin  # Reset to known-good
```

Filesystem-level controls:
```bash
chmod 755 /usr/bin/ls
chown root:root /usr/bin/ls
chattr +i /usr/bin/ls  # Immutable (prevents replacement)
```

## Attack Surface

- `/usr/bin` contains ~2000 binaries on average Debian system
- Each is potential hijack target
- Hash table persists across commands but not shells
- Most users never verify PATH order

## Limitations

- Immutable flag requires root to set/unset
- Does not prevent attacker with root access
- Hash table flush only affects current shell
- Child processes inherit poisoned environment

## Next Steps

- Test persistence mechanisms (profile files, systemd units)
- Automated integrity checking (AIDE, Tripwire)
- Capability-based restrictions (prevent arbitrary execution)
