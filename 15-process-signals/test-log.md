# Test Log — 15 Process Signals

## 01-zombie-factory.sh
- Status: tested
- Zombies visible in ps output with Z state
- Parent PIDs confirmed with ps --ppid

## 01-zombie-cleanup.sh
- Status: tested
- Correctly identifies zombie parents
- strace confirmation step requires sudo

## 02-trap-template.sh
- Status: tested
- SIGTERM triggers cleanup, temp file removed
- Normal completion exits 0, no cleanup message
- Double-trap bug fixed with trap - reset inside cleanup

## 01-ulimit-hardening.sh
- Status: tested
- limits.conf updated correctly
- PAM configured
- Requires logout/login to activate
- Verified with ulimit -u and ulimit -n

## Session 3 — SIGHUP, nohup, tmux, job control

## SIGHUP
- Tested nginx reload with kill -1 $(cat /run/nginx.pid)
- Master PID unchanged, workers replaced with new PIDs
- Config change applied with zero downtime

## nohup
- Confirmed process survives terminal close
- TTY changes from pts/0 to ? after terminal dies
- Process reparented to systemd user instance

## tmux
- Created, detached, reattached sessions successfully
- Work continues running after detach
- tmux attach -t NAME walks back into the session

## Job control
- fg, bg, jobs, Ctrl+z, disown tested hands-on
- Ctrl+z sends SIGSTOP — process frozen not dead
- bg sends SIGCONT — process resumes in background
- disown removes job from shell table — survives terminal death
