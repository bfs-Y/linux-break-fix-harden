#!/bin/bash
# HARDEN: Restrict /tmp execution

# Step 1 — check current /tmp mount options
echo "[CHECK] current /tmp mount options:"
mount | grep " /tmp "

# Step 2 — remount /tmp with restrictions
echo "[HARDEN] remounting /tmp with noexec,nosuid,nodev"
mount -o remount,noexec,nosuid,nodev /tmp

# Step 3 — verify
echo "[VERIFY] new /tmp mount options:"
mount | grep " /tmp "

# Step 4 — test execution is blocked
echo "#!/bin/bash" > /tmp/test.sh
chmod +x /tmp/test.sh
/tmp/test.sh && echo "[FAIL] execution still allowed" || echo "[PASS] execution blocked"
rm /tmp/test.sh
