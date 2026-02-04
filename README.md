# linux-break-fix-harden

Attack surface documentation for Linux system hardening. Each module documents exploitation, detection, and mitigation of a specific subsystem.

Not a tutorial. Assumes working knowledge of syscalls, file permissions, and basic incident response.

## Structure
```
XX-subsystem-name/
├── break/     - Exploitation artifacts (scripts, payloads, techniques)
├── fix/       - Detection and recovery procedures
├── harden/    - Preventive controls and their tradeoffs
└── drills/    - Timed scenarios for competency validation
```

## Scope

Covers userspace attack surface on modern Linux (kernel 5.x+, systemd-based).

Out of scope:
- Kernel exploits (requires separate repo)
- Container escapes (Docker/k8s have dedicated tooling)
- Hardware-level attacks (TPM bypass, cold boot, etc.)

## Modules

- `01-usr-execution` - Command resolution, PATH manipulation, hash table poisoning
- `02-bin-recovery` - [Planned] Boot-time command availability, emergency shell constraints

## Prerequisites

Ubuntu 22.04+ or equivalent. Uses modern merged `/usr` layout unless otherwise noted.

Some drills require legacy `/bin` split. Use Alpine containers:
```bash
docker run -it --rm alpine:3.19 /bin/sh
```

## Anti-Pattern Warnings

This is not:
- CTF writeups (real systems, not gamified scenarios)
- Cert prep material (no OSCP/CEH alignment)
- Penetration testing methodology (focuses on post-access hardening)

## Known Gaps

- Limited coverage of SELinux/AppArmor policy exploitation
- Does not address supply chain attacks (compromised packages)
- Assumes attacker does not have kernel write access

Use for competency development in defensive security roles. Not a checklist.
