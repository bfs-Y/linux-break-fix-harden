# Test Log — 05-lib-hijacking

## Drill 01: Detect Malicious Library Persistence
Date: 2026-03-11
Result: Not yet run independently
Notes: Covered during module build session

## Drill 02: Blind Library Triage
Date:
Result: Not yet run
Notes:

## Drill 03: Cleanup Order
Date:
Result: Not yet run
Notes:

## Drill 04: Disguised Library
Date:
Result: Not yet run
Notes:

## Drill 05: Timed Incident Response
Date: 2026-03-11
Result: Pass (second attempt)
Notes: First attempt failed — ran wrong attack (puts hijack instead of ld.so.preload persistence), gcc not installed, binutils missing. Second attempt clean. Correct order: preload file removed before library. Detection confirmed via cat, stat, strings, dpkg -S.

## Break Scenario 01: ld.so.preload Persistence
Date: 2026-03-11
Result: Pass
Notes: Constructor payload compiled to /lib/evil.so, registered in /etc/ld.so.preload. Every binary fired [PWNED]. Removed cleanly.
