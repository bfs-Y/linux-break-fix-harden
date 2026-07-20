# linux-break-fix-harden — Backlog

## Repo-wide security/fundamentals split — COMPLETE (2026-07-17)
All 10 originally-flagged folders migrated to linux-security-labs, verified
via actual file content (not just names), using the test: "is there an
attacker in this scenario, or is this a neutral mechanism/misconfiguration?"

Final migration results:
- 01-usr-execution → phase7-secops/usr-execution (whole folder, confirmed
  security throughout, no split needed)
- 04-sbin-admin → SPLIT: break/fix/harden scripts + drills/05-system-audit.md
  moved to phase3-access-control/sbin-admin (security); drills 01-04
  (sbin-inventory, user-management, filesystem-ops, service-management)
  stayed here — genuinely neutral admin-tool reference content
- 05-lib-hijacking → phase7-secops/lib-hijacking (whole folder)
- 06-tmp-attacks → phase7-secops/tmp-attacks (whole folder)
- 07-var-attacks → phase6-logging-monitoring/var-attacks (whole folder —
  log/monitoring integrity specifically, not general secops)
- 08-boot-security → phase7-secops/boot-security (whole folder)
- 09-root-hardening → phase7-secops/root-hardening (whole folder)
- 10-dev-attacks → phase7-secops/dev-attacks (whole folder)
- 11-etc-hardening → phase7-secops/etc-hardening (whole folder, confirmed:
  backdoor account planting via /etc/passwd + /etc/shadow)
- 12-home-security → phase7-secops/home-security (whole folder)

All drills in the 6 batch-moved folders individually reviewed after the
move — confirmed all genuinely security-framed, no neutral content found
(unlike 04-sbin-admin, which did require a split).

## Remaining fundamentals content in this repo (final, verified shape)
- 02-bin-recovery — /usr mount failure simulation, no attacker
- 04-sbin-admin (drills only) — sbin tool inventory, user management,
  filesystem ops, service management reference
- 13-permission-directories — basics-only permission/ownership lab,
  tested live on VM
- 14-users-sudo — basics-only useradd/usermod -aG lab, tested live on VM
- 15-process-signals — zombie process creation for inspection
- 16-networking — interface/route/DNS basics

## Still open — thin folders (not urgent, revisit later)
13-permission-directories and 14-users-sudo have real break/fix content now
(added 2026-07-16/17), but still missing: README.md, test-log.md,
postmortem/ for both. harden/ likely not needed for basics-only scope —
confirm before deciding.

## Still open — no postmortem content anywhere in this repo
Confirmed: linux-break-fix-harden has zero postmortem/ entries across any
topic folder. Revisit — decide whether to backfill at least one real
postmortem here, matching the standard already established in
linux-networking-labs (ARP capture, DNS backup-corruption) and
linux-security-labs.

## Resolved — process note for future reference
Earlier in this migration, testing was accidentally done on the HOST
instead of the training VM (13-permission-directories/14-users-sudo initial
testing). Caught, cleaned up, no lasting harm. Lesson: always confirm
`hostname` before running break/fix scripts. A parallel attempt to scp the
whole repo to the VM also failed (git object permission errors) — resolved
by using `git clone`/`git pull` instead of direct file copy going forward.
