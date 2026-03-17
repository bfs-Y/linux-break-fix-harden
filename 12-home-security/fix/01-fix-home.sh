#!/bin/bash
chmod 700 /home/testuser
chmod 644 /home/testuser/.bashrc
sed -i '/dev\/tcp/d' /home/testuser/.bashrc
chmod 700 /home/testuser/.ssh
chmod 600 /home/testuser/.ssh/authorized_keys
chown testuser:testuser /home/testuser/.ssh/authorized_keys
> /home/testuser/.ssh/authorized_keys
