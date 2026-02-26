# Drill 04: Capabilities

Time: 8 minutes

## What Are Capabilities?

Instead of "run as root" (SUID), Linux lets you grant specific powers.

Example: ping needs raw network access. Instead of making it SUID root (all root powers), give it just CAP_NET_RAW (network only).

## Setup
```bash
docker run -it --rm ubuntu:22.04 /bin/bash
apt update && apt install -y libcap2-bin python3
```

## Find Binaries with Capabilities
```bash
getcap -r / 2>/dev/null
```

Shows which programs have special capabilities.

On fresh Ubuntu, you'll see ping with CAP_NET_RAW.

## Check Specific Binary
```bash
getcap /usr/bin/ping
```

Shows: `cap_net_raw=ep`

Means: ping has CAP_NET_RAW (raw network) capability.

## Common Capabilities
```
CAP_NET_RAW      - raw network (ping)
CAP_NET_BIND_SERVICE - bind to ports <1024
CAP_DAC_OVERRIDE - bypass file permissions
CAP_SETUID       - change user ID
CAP_SYS_ADMIN    - almost everything (dangerous)
```

## Dangerous Example: CAP_SETUID

If a binary has CAP_SETUID, it can become any user (including root).

Simulate bad config - give python CAP_SETUID:
```bash
setcap cap_setuid+ep /usr/bin/python3
getcap /usr/bin/python3
```

Shows: `cap_setuid=ep`

## Exploit It

Create regular user:
```bash
useradd -m victim
su - victim
```

Now as victim, use python to become root:
```bash
python3 -c 'import os; os.setuid(0); os.system("/bin/bash")'
```

Check:
```bash
whoami
id
```

You're root now. victim became root without SUID.

## Why This Happened

python3 has CAP_SETUID capability.

CAP_SETUID lets you change your user ID.

You changed to uid 0 (root).

Game over.

## Defense

Remove dangerous capability:
```bash
exit  # Back to root
setcap -r /usr/bin/python3
getcap /usr/bin/python3
```

Should show nothing (capability removed).

## Audit Capabilities
```bash
getcap -r / 2>/dev/null
```

Check each result. Ask: "Does this program NEED this capability?"

Dangerous capabilities to watch for:
- CAP_SETUID (can become anyone)
- CAP_SYS_ADMIN (nearly full root)
- CAP_DAC_OVERRIDE (bypass file permissions)

## Capabilities vs SUID

SUID: All or nothing. Program runs as root.

Capabilities: Granular. Program gets specific powers only.

Better: Use capabilities when possible.

Still dangerous: If wrong program gets wrong capability.

## Exit
```bash
exit
```

## Key Lesson

Capabilities are more secure than SUID if used correctly.

But CAP_SETUID on python is as bad as SUID root.

Audit with: `getcap -r / 2>/dev/null`
