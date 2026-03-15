## Break Scenario 01: SSH Key Exposure
Date: 2026-03-14
Result: Demonstrated
Notes: Generated root SSH keypair. Weakened id_rsa to 644 — world readable.
Simulated history with attacker commands. Detection via ls -la /root/.ssh/
and find with perm check. Fix requires permission correction AND key rotation
— fixing permissions alone does not revoke stolen key access.

## Drills 01-05
Result: Not yet run independently
Notes: Run all five before starting module 10.
