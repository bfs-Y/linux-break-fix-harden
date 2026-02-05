# Test Execution Log

## Date: 2025-02-05
## Environment: Ubuntu 24.04, zsh shell

### Break Phase

Command:
```bash
source break/path-hijack.sh
ls
```

Result:
```
[COMPROMISED] Malicious ls executed
Exfiltrating data to attacker...
fake-ls.c  path-hijack.sh
```

**Confirmed:** Exploit successful. Malicious binary executed.

---

### Detection Phase

Command:
```bash
bash fix/detect-hijack.sh
```

Result:
```
=== ls ===
ls is /tmp/evil/ls
ls is /usr/bin/ls
-rwxrwxr-x ibnb:ibnb /tmp/evil/ls

[!] Writable: /tmp/evil
```

**Confirmed:** Detection identified malicious binary, writable directory, and non-root ownership.

---

### Restoration Phase

Command (incorrect):
```bash
bash restore-trust.sh  # Failed - subprocess doesn't affect parent shell
```

Command (correct):
```bash
source restore-trust.sh
# or manually:
export PATH=/usr/bin:/bin:/usr/sbin:/sbin
ls
```

Result:
```
detect-hijack.sh  restore-trust.sh
```

**Confirmed:** Trust restored after sourcing script or manual PATH reset.

---

## Observations

1. Hash table flushing only affects current shell process
2. Subshell modifications don't propagate to parent
3. `type -a` shows all PATH matches, malicious binary listed first
4. Writable directory detection caught `/tmp/evil`
5. Ownership check revealed non-root binary (suspicious)

## Failure Points

- Initial restoration attempt used `bash script.sh` instead of `source script.sh`
- Scripts assume bash hash syntax, incompatible with zsh
- Need to document: "Must be sourced, not executed"

## Shell Compatibility Issues

- zsh: `hash` command (no `-t` flag)
- bash: `hash -t` command
- Detection script works in both (uses `type -a` and `which`)
- Restoration script must be sourced to affect current shell

## Lessons

Incident response scripts that modify shell state (PATH, aliases, functions) must be sourced.  
Cannot rely on subprocess execution for environment changes.  
Always verify with `strace -e execve` as ground truth.
