# /var Attacks

/var holds runtime data — logs, cron jobs, mail, package state, backups. Most
of it is owned by root but readable by everyone. Some of it is writable by
services running as non-root. That combination creates real attack surface.

An attacker who gets root does two things immediately: plants persistence and
covers tracks. /var/spool/cron/crontabs is where user persistence lands.
/var/log is where the evidence lives. Control both and the compromise becomes
invisible.

## Threat Model

Log tampering is post-compromise cleanup. Attacker gets in, does damage, then
surgically removes their IP and login entries from auth.log. A defender looking
at local logs sees nothing. The only reliable counter is shipping logs off the
system before they can be touched.

Cron persistence via /var/spool/cron requires no special tricks. Any user runs
crontab -e and plants a reverse shell or payload. Fires every minute. Survives
reboots. Goes unnoticed unless someone audits crontabs explicitly.

## What Was Tested

- Three log tampering methods: surgical deletion, truncation, fake entries
- Detection of tampered logs through pattern analysis and metadata
- Cron persistence via /var/spool/cron/crontabs
- Detection and removal using crontab -r
- Append-only protection on auth.log with chattr +a

## Break 01: Log Tampering

Simulated a complete attack chain in auth.log — failed login, successful login,
sudo escalation. Then surgically removed the SSH entries using sed, leaving
only the sudo entry with no preceding login. That gap is the IOC.

Three tampering methods:
- sed -i '/attacker-ip/d' — removes specific lines, log looks normal
- > /var/log/auth.log — truncates entire file, obvious but destroys evidence
- echo "fake entry" > /var/log/auth.log — replaces with decoy content

Detection:
    ls -la /var/log/auth.log
    grep "sudo" /var/log/auth.log
    grep "sshd" /var/log/auth.log
    journalctl _COMM=sshd --no-pager | tail -20

A sudo entry with no preceding SSH login is impossible on a normal system.
That gap means the log was edited.

## Break 02: Cron Persistence via /var/spool/cron

Added a persistent cron job as root using crontab -e. Job stored at
/var/spool/cron/crontabs/root. Fired every minute automatically.

Detection:
    crontab -l
    cat /var/spool/cron/crontabs/root
    ls -la /var/spool/cron/crontabs/

Removal:
    crontab -r

## Harden

    # Make auth.log append-only — even root cannot delete entries
    chattr +a /var/log/auth.log

    # Verify the attribute
    lsattr /var/log/auth.log

    # Audit all user crontabs
    ls -la /var/spool/cron/crontabs/
    for user in /var/spool/cron/crontabs/*; do
        echo "=== $user ==="
        cat "$user"
    done

The only reliable defense against log tampering is remote log shipping.
chattr +a slows attackers down but root can remove the attribute with
chattr -a before tampering.

## Failure Modes

- Relying on local logs for incident response — root can modify them
- Not auditing /var/spool/cron/crontabs/ — crontab -l only shows current user
- Assuming chattr +a is permanent — root can remove it
- Missing the pattern: sudo entry with no preceding login means log was edited
- Not checking journald — it may have entries auth.log is missing

## Next

- /boot security — bootloader hardening, GRUB password, initrd tampering
