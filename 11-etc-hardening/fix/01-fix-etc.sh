#!/bin/bash
chmod 640 /etc/shadow
chmod 644 /etc/passwd
sed -i '/^backdoor/d' /etc/passwd
sed -i '/^backdoor/d' /etc/shadow
