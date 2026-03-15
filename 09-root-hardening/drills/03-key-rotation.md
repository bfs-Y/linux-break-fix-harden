# Drill 03: Rotate Compromised SSH Key

**Time limit:** 8 minutes
**Environment:** Root SSH key confirmed stolen. Rotate it completely.

## Scenario

Forensics confirmed the attacker copied /root/.ssh/id_rsa. You need to
rotate the key and ensure the old key no longer works on any system.

## Tasks

1. Generate a new keypair
2. Identify all servers with the old public key in authorized_keys
3. Replace old key with new key on each server
4. Verify old key no longer authenticates

## Commands in Order

    ssh-keygen -t ed25519 -f /root/.ssh/id_rsa_new
    cat /root/.ssh/id_rsa.pub
    # on each target server:
    grep -r "old-key-fingerprint" /root/.ssh/authorized_keys
    # replace old entry with new public key
    ssh -i /root/.ssh/id_rsa_new root@<target> "echo connected"

## Success Criteria

- New keypair generated
- Old public key identified and removed from all authorized_keys
- New key tested and working
- Old private key deleted from /root/.ssh/

## Failure Modes

- Generating new key but missing one server with old authorized_keys entry
- Not deleting the old private key after rotation
- Not testing new key before deleting old one

## Solution

[Run drill first. Fill this in after at least two attempts.]
