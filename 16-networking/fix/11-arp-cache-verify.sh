#!/bin/bash
# Detect and fix poisoned ARP cache

GATEWAY="192.168.122.1"
IFACE=$(ip route | grep default | awk '{print $5}' | head -1)
LEGITIMATE_MAC=$(ip neigh show | grep $GATEWAY | awk '{print $5}')

echo "[CHECK] Detected interface: $IFACE"
echo "[CHECK] Current ARP entry for gateway:"
ip neigh show | grep $GATEWAY

if [ -z "$LEGITIMATE_MAC" ]; then
    echo "[INFO] No ARP entry for gateway yet. Triggering ARP resolution..."
    ping -c 1 $GATEWAY > /dev/null 2>&1
    LEGITIMATE_MAC=$(ip neigh show | grep $GATEWAY | awk '{print $5}')
fi

echo "[INFO] Current MAC: $LEGITIMATE_MAC"
echo "[FIX] Flushing ARP cache..."
sudo ip neigh flush all
echo "[FIX] Re-resolving gateway MAC via ping..."
ping -c 1 $GATEWAY > /dev/null 2>&1
echo "[FIX] Verified:"
ip neigh show | grep $GATEWAY
