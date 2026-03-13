## Drill 05: Timed Incident Response

Date: 2026-03-12
Result: Pass (second attempt)
Notes: First attempt skipped attack phase — cleaned up files that didn't exist.
Second attempt correct. Attack planted, fired as root, detected via crontab
and /tmp audit, removed in correct order, clean execution confirmed.


## Break Scenario 02: Symlink Attack
Date: 2026-03-13
Result: Pass
Notes: Created symlink at /tmp/report.txt pointing to /etc/cron.d/backdoor.
Root script wrote cron job into backdoor file via symlink. Backdoor fired
as root every minute. Removed by deleting /etc/cron.d/backdoor and
/tmp/report.txt symlink. Verified clean after one cron cycle.
