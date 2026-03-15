#!/bin/bash
# FIX: Detect and remediate root directory exposure

echo "[DETECT] /root/.ssh permissions:"
ls -la /root/.ssh/ 2>/dev/null

echo "[DETECT] checking for weak key permissions:"
find /root/.ssh -type f -perm /044 && echo "[ALERT] keys readable by others" || echo "permissions ok"

echo "[DETECT] bash history:"
cat /root/.bash_history 2>/dev/null

echo "[DETECT] checking HISTFILE suppression:"
echo "HISTFILE=$HISTFILE"
echo "HISTSIZE=$HISTSIZE"

echo "[FIX] fixing permissions:"
chmod 700 /root/.ssh
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/id_rsa.pub
chmod 600 /root/.ssh/authorized_keys 2>/dev/null

echo "[FIX] rotating compromised key:"
echo "run: ssh-keygen -t ed25519 -f /root/.ssh/id_rsa"
echo "then: update authorized_keys on all target servers"
echo "then: remove old public key from all authorized_keys files"

echo "[VERIFY] permissions after fix:"
ls -la /root/.ssh/
