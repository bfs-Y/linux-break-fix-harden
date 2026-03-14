# Drill 04: Apply and Test chattr Protection

**Time limit:** 5 minutes
**Environment:** Fresh system. Apply log hardening and test it.

## Scenario

You are hardening a server before deployment. Apply append-only protection
to auth.log and verify it works. Then test the limitation — can root bypass it?

## Tasks

1. Apply chattr +a to auth.log
2. Verify the attribute is set
3. Try to delete a line with sed — should fail
4. Try to remove the attribute as root — confirm root can bypass it

## Commands in Order

    chattr +a /var/log/auth.log
    lsattr /var/log/auth.log
    sed -i '/test/d' /var/log/auth.log
    chattr -a /var/log/auth.log
    lsattr /var/log/auth.log

## Success Criteria

- Append-only attribute confirmed with lsattr
- sed modification blocked with operation not permitted
- Root bypass confirmed — chattr -a succeeds as root
- Understand why remote logging is the real solution

## Failure Modes

- Assuming chattr +a stops root permanently
- Not testing the bypass
- Not verifying with lsattr after applying

## Solution

[Run drill first. Fill this in after at least two attempts.]
