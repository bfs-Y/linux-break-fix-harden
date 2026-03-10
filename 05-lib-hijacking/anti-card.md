# Anti-Card: /usr Command Execution & Trust

## Front

You suspect PATH hijacking on a production server. 
Shell is active. You cannot restart it. 
What's your investigation sequence?

## Back

### 1. Identify Scope
```bash
echo $PATH  # Check for suspicious directories
```

Look for:
- `/tmp` or other writable paths
- Unfamiliar directories
- User-owned paths before system paths

### 2. Find Compromised Commands
```bash
type -a ls    # Shows all PATH matches
type -a ps
type -a cat
```

First match is what executes. Anything before `/usr/bin` is suspicious.

### 3. Analyze Without Execution
```bash
strings /tmp/evil/ls     # Read script content
stat /tmp/evil/ls        # Check ownership/perms
file /tmp/evil/ls        # Verify file type
```

Look for:
- `curl`, `wget` (exfiltration)
- File writes to `/tmp` (local logging)
- `tee` (data interception)
- Non-root ownership

### 4. Verify Ground Truth
```bash
strace -e execve ls 2>&1 | grep execve
```

Only way to see actual syscall. Hash table and `type` can lie.

### 5. Restore Trust
```bash
export PATH=/usr/bin:/bin:/usr/sbin:/sbin
hash -r
type -a ls    # Verify clean resolution
```

Both steps required. PATH change alone leaves poisoned hash.

---

## What /usr Is

Second-tier system binaries. Not required for boot. 
Contains ~2000 userland tools on typical Debian system. 
Modern distros: `/bin` symlinks to `/usr/bin` (merged layout).

## How Execution Works

1. Shell checks hash table (command → path cache)
2. If miss, walks PATH left to right
3. First executable match wins
4. Path cached in hash table
5. `execve()` syscall with resolved path

## Common Compromise Vectors

- Writable directory early in PATH (`/tmp`, `.`, `~/bin`)
- Malicious binary with common name
- User executes once → hash poisoned
- Persistence across commands in same session

## Detection Without Execution

- `type -a <cmd>` - All PATH matches
- `strings <path>` - Read script/binary content
- `stat <path>` - Ownership/permissions
- `strace -e execve <cmd>` - Ground truth (actual syscall)

## Trust Restoration
```bash
hash -r                           # Flush hash table
export PATH=/usr/bin:/bin         # Reset to known-good
type -a ls                        # Verify each critical command
chattr +i /usr/bin/ls             # Immutable flag (prevents replacement)
```

## Why Hash Table Matters

- Persists across commands but NOT across shells
- PATH changes don't clear it
- `type` uses it (can show wrong path)
- `strace` bypasses it (shows truth)
- Must flush during incident response

## Attack Surface

- `/usr/bin`: ~2000 binaries
- Each is potential hijack target
- Most users never verify PATH order
- Hash poisoning is silent

## Limitations of Defenses

- Immutable flag requires root to set/unset
- Doesn't prevent attacker with root access
- Hash flush only affects current shell
- Child processes inherit poisoned environment

---

## Tags

`execution`, `path`, `trust`, `incident-response`, `syscall`, `hash-poisoning`, `command-resolution`
