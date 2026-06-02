#!/bin/bash
# Simulates a signal-based DoS attack
# Repeatedly sends SIGTERM to a target process
# Safe — targets a sleep process, not a real service

echo "=== Starting target process ==="
sleep 1000 &
TARGET_PID=$!
echo "Target PID: $TARGET_PID"

echo ""
echo "=== Starting signal attack ==="
echo "Sending SIGTERM every 2 seconds..."
echo "Use fix/05-detect-signal-attack.sh to investigate"
echo "Press Ctrl+C to stop the attack"
echo ""

while kill -0 $TARGET_PID 2>/dev/null; do
    echo "Sending SIGTERM to PID $TARGET_PID"
    kill -15 $TARGET_PID
    sleep 2
    sleep 1000 &
    TARGET_PID=$!
    echo "Target restarted as PID $TARGET_PID"
done
