#!/bin/bash
# Fix 05: Restrict an over-permissive port rule to a specific subnet
# Pairs with: break/05-firewall-misconfig.sh

PORT=9090
ALLOWED_SUBNET="192.168.122.0/24"

echo "[INVESTIGATE] Current rule before fix:"
sudo ufw status verbose | grep "$PORT"

echo "[FIX] Removing the wide-open rule..."
sudo ufw delete allow "$PORT"/tcp

echo "[FIX] Adding properly scoped rule..."
sudo ufw allow from "$ALLOWED_SUBNET" to any port "$PORT" proto tcp

echo "[VERIFY] Friendly view:"
sudo ufw status verbose | grep "$PORT"

echo "[VERIFY] Raw kernel rule:"
sudo iptables -L ufw-user-input -n -v | grep "$PORT"
