#!/bin/bash
# Detects signal-based attacks against a process
# Uses strace to capture signal attribution in real time
# Requires PID of the target process

if [ -z "$1" ]; then
    echo "Usage: $0 <PID>"
    echo "Example: $0 1234"
    exit 1
fi

PID=$1

echo "=== Signal attack detection ==="
echo "Monitoring PID $PID for incoming signals"
echo "Press Ctrl+C to stop"
echo ""
echo "What to look for:"
echo "  si_code=SI_USER  — signal sent by a user process"
echo "  si_pid=XXXX      — PID of the sender"
echo "  si_uid=XXXX      — UID of the sender"
echo ""

sudo strace -p $PID -e trace=signal 2>&1 | while read line; do
    echo "$line"
    if echo "$line" | grep -q "si_pid"; then
        SENDER_PID=$(echo "$line" | grep -o 'si_pid=[0-9]*' | cut -d= -f2)
        SENDER_UID=$(echo "$line" | grep -o 'si_uid=[0-9]*' | cut -d= -f2)
        echo ""
        echo "=== SIGNAL DETECTED ==="
        echo "Sender PID: $SENDER_PID"
        echo "Sender UID: $SENDER_UID"
        echo "Sender command: $(cat /proc/$SENDER_PID/cmdline 2>/dev/null | tr '\0' ' ')"
        echo "Sender user: $(getent passwd $SENDER_UID | cut -d: -f1)"
        echo "========================"
        echo ""
    fi
done
