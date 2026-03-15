# /root Hardening

/root is the home directory of the most privileged account on the system.
What lives there — SSH keys, bash history, application configs — tells an
attacker everything about where root has been and where root can go next.

A compromised private key in /root/.ssh/id_rsa is worse than a compromised
password. Passwords can be changed. Every server that trusts that key stays
compromised until the key is rotated across all authorized_keys files. Most
admins miss one.

## Threat Model

Attacker gets temporary root access — via SUID exploit, sudo misconfiguration,
or physical access. They copy /root/.ssh/id_rsa, clear bash history, and leave.
The initial vector gets patched. The SSH key stays valid. Six months later they
walk back in.

## What Was Tested

- SSH private key exposure via weak file permissions
- Bash history tampering via deletion and HISTFILE suppression
- Detection of exposed keys and missing history
- Permission hardening on /root/.ssh
- Making bash history append-only with chattr +a
- SSH daemon hardening — PermitRootLogin and PasswordAuthentication

## Break: SSH Key Exposure

Generated root SSH keypair. Weakened permissions on private key to 644 —
world readable. Any user on the system can read it and authenticate as root
to any server with the corresponding public key in authorized_keys.

Detection:

    ls -la /root/.ssh/
    find /root/.ssh -type f -perm /044
    stat /root/.ssh/id_rsa

Private key should always be 600. Public key 644 is fine.

## Fix

    chmod 700 /root/.ssh
    chmod 600 /root/.ssh/id_rsa
    chmod 644 /root/.ssh/id_rsa.pub
    chmod 600 /root/.ssh/authorized_keys

Fixing permissions is not enough if the key was already read. Rotate it:

    ssh-keygen -t ed25519 -f /root/.ssh/id_rsa
    # update authorized_keys on every target server
    # remove old public key from every authorized_keys file

## Harden

    # Lock down directory
    chmod 700 /root
    chmod 700 /root/.ssh

    # Make history append-only
    chattr +a /root/.bash_history

    # Enforce history in .bashrc
    echo "readonly HISTFILE" >> /root/.bashrc
    echo "HISTTIMEFORMAT='%F %T '" >> /root/.bashrc

    # SSH daemon settings
    PermitRootLogin prohibit-password
    PasswordAuthentication no

PermitRootLogin prohibit-password allows key-based root login but blocks
password authentication. Combined with strong key management this is the
right balance for systems that need root SSH access.

## Failure Modes

- Changing root password after key theft — does nothing, key still works
- Rotating key on one server but missing others — attacker keeps access
- Deleting .bash_history — auditd still has the record at kernel level
- Setting HISTSIZE=0 thinking it disables history — it just limits size
- Weak permissions on /root/.ssh/ directory itself — 755 exposes key list

## Next

- /dev attacks — device file abuse, ptrace, /dev/null replacement
