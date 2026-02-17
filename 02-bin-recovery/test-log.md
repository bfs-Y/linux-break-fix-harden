# Test Log - /bin Recovery

Date: 2026-02-06

## Drill 01: Tool Inventory

Ran Alpine to see the real /bin split:
```bash
docker run -it --rm alpine:3.19 /bin/sh
ls /bin | wc -l      # 82
ls /usr/bin | wc -l  # 143
vi                   # works, it's in /usr/bin
```

/bin has 82 commands. /usr/bin has 143.

vi exists but it's in /usr/bin, not /bin. If /usr fails to mount, you lose it.

---

## Drill 02: Manual Mount

Broke /usr on purpose:
```bash
mv /usr /usr.unmounted
mkdir /usr
vi  # not found
```

Fixed it:
```bash
mount /usr.unmounted /usr
vi  # works now
ls /usr/bin | wc -l  # 143 binaries back
```

mount reconnected everything. Tools came back.

---

## Drill 03: Log Analysis

Searched fake boot log for errors:
```bash
grep FAILED /var/log/boot.log
grep ERROR /var/log/boot.log
grep -c FAILED /var/log/boot.log  # 3
grep -c ERROR /var/log/boot.log   # 2
```

Found /dev/sda2 has filesystem errors.

3 failed services. 2 errors total.

grep -c worked because Alpine doesn't have wc in /bin.

---

## Drill 04: Process Management

[Skipped for now. Need more background on processes.]

---

## Drill 05: Text Editing

[Fill this after testing]

---

## What I Learned

Alpine /bin is way smaller than Ubuntu (82 vs 1580). That's because Ubuntu merged everything.

Docker needs --privileged flag to allow mount. Otherwise you get permission denied.

wc isn't in Alpine's /bin. Had to use grep -c instead.

vi is in /usr/bin, not /bin. Emergency shell without /usr means no vi either.

---

## Problems I Hit

Confused Docker container with my host system at first.

Learned to check hostname before running destructive commands.

