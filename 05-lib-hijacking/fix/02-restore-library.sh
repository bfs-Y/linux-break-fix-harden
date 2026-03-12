#!/bin/bash
# FIX: Restore a replaced system library from package cache
# Must run before dpkg itself breaks — or boot from external media

# Step 1 — detect the mismatch
echo "[DETECT] checking libselinux1 integrity"
dpkg -V libselinux1

# Step 2 — record current bad checksum
echo "[EVIDENCE] current checksum:"
md5sum /lib/x86_64-linux-gnu/libselinux.so.1

# Step 3 — extract clean library from package cache
echo "[FIX] extracting clean library from .deb"
dpkg-deb -x /var/cache/apt/archives/libselinux1*.deb /tmp/restore

# Step 4 — restore
cp /tmp/restore/lib/x86_64-linux-gnu/libselinux.so.1 \
   /lib/x86_64-linux-gnu/libselinux.so.1

# Step 5 — verify checksum matches known good
echo "[VERIFY] checksum after restore:"
md5sum /lib/x86_64-linux-gnu/libselinux.so.1

# Step 6 — confirm dpkg works again
dpkg -V libselinux1 && echo "[CLEAN] library restored successfully"
