# Drill 05: Timed Incident Response — /tmp Attack

**Time limit:** 10 minutes
**Environment:** Full scenario. No hints.

## Scenario

3am. Alert fires. Root process executing unexpected code every minute.
You SSH in. Nothing else. Figure it out, stop it, fix it, verify clean.
Do it from memory.

## Tasks

1. Find the malicious binary in /tmp
2. Identify the vulnerable crontab entry
3. Remove the binary
4. Fix the crontab PATH
5. Verify clean cron execution
6. Document findings in test-log.md

## Pass Criteria

- Full triage completed under 10 minutes
- Both the binary and the crontab PATH fixed
- Clean cron execution confirmed
- No steps done by guessing — every command intentional

## Failure Modes

- Fixing binary but not PATH
- Not confirming clean execution after fix
- Timeout
- Checking logs before /tmp and crontab

## Solution

[Run drill first. Fill this in after at least two attempts.]
