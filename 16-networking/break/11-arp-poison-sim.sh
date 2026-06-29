#!/bin/bash
# Simulate a poisoned ARP cache entry

GATEWAY="192.168.122.1"
FAKE_MAC="aa:bb:cc:dd:ee:ff"
IFACE=$(ip route | grep default | awk '{print $5}' | head -1)

echo "[BREAK] Detected interface: $IFACE"
echo "[BREAK] Injecting fake ARP entry for $GATEWAY"
sudo ip neigh replace $GATEWAY dev $IFACE lladdr $FAKE_MAC
echo "[BREAK] ARP cache now shows:"
ip neigh show | grep $GATEWAY
echo "[BREAK] All traffic to gateway now goes to $FAKE_MAC"
