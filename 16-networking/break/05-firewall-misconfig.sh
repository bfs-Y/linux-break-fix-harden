#!/bin/bash
# Break 05: Open a port to the entire internet instead of restricting it
# Effect: simulates the "SSH open to 0.0.0.0/0" audit scenario, using port 9090
# Recovery: fix/05-firewall-restrict.sh

PORT=9090

echo "[BREAK] Opening port $PORT to the entire internet..."
sudo ufw allow "$PORT"/tcp
echo "[VERIFY] Rule as written:"
sudo ufw status verbose | grep "$PORT"
