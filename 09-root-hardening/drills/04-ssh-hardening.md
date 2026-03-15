# Drill 04: Harden SSH Daemon Configuration

**Time limit:** 5 minutes
**Environment:** Default SSH config. Apply hardening.

## Scenario

Fresh server. Default sshd_config allows password authentication and
possibly root login with password. Harden it before exposing to the internet.

## Tasks

1. Check current SSH daemon settings
2. Disable password authentication
3. Set PermitRootLogin to prohibit-password
4. Restart SSH and verify settings applied

## Commands in Order

    grep -E "(PermitRootLogin|PasswordAuthentication)" /etc/ssh/sshd_config
    sed -i 's/#PermitRootLogin.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    grep -E "(PermitRootLogin|PasswordAuthentication)" /etc/ssh/sshd_config
    systemctl restart sshd 2>/dev/null || service ssh restart

## Success Criteria

- PermitRootLogin set to prohibit-password
- PasswordAuthentication set to no
- SSH service restarted successfully
- Settings confirmed in config file

## Failure Modes

- Setting PermitRootLogin no — locks out legitimate root SSH access
- Not restarting sshd — changes not applied
- Not verifying the sed actually changed the right lines

## Solution

[Run drill first. Fill this in after at least two attempts.]
