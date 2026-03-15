#!/bin/bash
# HARDEN: Lock down /root directory and SSH configuration

echo "[HARDEN] setting correct permissions on /root:"
chmod 700 /root
chmod 700 /root/.ssh 2>/dev/null
chmod 600 /root/.ssh/id_rsa 2>/dev/null
chmod 644 /root/.ssh/id_rsa.pub 2>/dev/null
chmod 600 /root/.ssh/authorized_keys 2>/dev/null

echo "[HARDEN] enforcing bash history:"
echo "HISTFILE=/root/.bash_history" >> /root/.bashrc
echo "HISTSIZE=10000" >> /root/.bashrc
echo "HISTTIMEFORMAT='%F %T '" >> /root/.bashrc
echo "readonly HISTFILE" >> /root/.bashrc

echo "[HARDEN] locking history file append-only:"
touch /root/.bash_history
chattr +a /root/.bash_history

echo "[HARDEN] checking SSH config:"
grep -E "(PermitRootLogin|PasswordAuthentication|AuthorizedKeysFile)" /etc/ssh/sshd_config 2>/dev/null

echo "[HARDEN] recommended sshd_config settings:"
echo "PermitRootLogin prohibit-password"
echo "PasswordAuthentication no"
echo "AuthorizedKeysFile .ssh/authorized_keys"

echo "[VERIFY] final permissions:"
ls -la /root/
ls -la /root/.ssh/ 2>/dev/null
