# Test Log — 05-lib-hijacking

## Break Scenario 01: ld.so.preload Persistence
Date: 2026-03-11
Result: Pass
Notes: Constructor payload compiled to /lib/evil.so, registered in
/etc/ld.so.preload. Every binary fired [PWNED]. Removed cleanly.
Correct order: preload file before library.

## Break Scenario 02: .so Replacement
Date: 2026-03-12
Result: Pass (attack), Incomplete (recovery)
Notes: Replaced libselinux.so.1 with malicious version. Checksum changed
from 2f9a5f397d7c48241f10e166af92adff to 1fa96e351eb2a77be27cfabd34671088.
dpkg, ls, cp all broke — cascading failure. Recovery failed because package
cache was empty and all tools depending on libselinux were broken.
Real recovery requires external media or booting outside compromised OS.

## Drill 05: Timed Incident Response
Date: 2026-03-11
Result: Pass (second attempt)
Notes: First attempt failed — wrong attack planted, gcc missing, binutils
missing. Second attempt clean. Detection and removal in correct order confirmed.

## Drills 01-04
Result: Not yet run independently
Notes: Run these before starting module 06.
