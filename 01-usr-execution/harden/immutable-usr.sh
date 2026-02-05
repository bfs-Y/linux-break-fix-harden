#!/bin/bash
# Apply immutability to critical binaries in /usr/bin

CRITICAL_BINS=(
    "ls" "cat" "grep" "ps" "bash" "sh"
    "sudo" "su" "mount" "umount"
)

echo "[*] Setting immutable flag on critical binaries..."

for bin in "${CRITICAL_BINS[@]}"; do
    path="/usr/bin/$bin"
    if [ -f "$path" ]; then
        sudo chattr +i "$path"
        echo "  [✓] $bin"
    else
        echo "  [!] $bin not found"
    fi
done

echo "
[*] Verify with: lsattr /usr/bin/ls"
echo "[*] Remove with: sudo chattr -i /usr/bin/ls"
echo "
[!] Warning: Immutable flag prevents updates"
echo "[!] Remove before system upgrades"
