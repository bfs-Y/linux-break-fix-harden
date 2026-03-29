# Drill 02 — Privileged group audit

Find all users in sudo and admin groups.

Commands:
getent group sudo
getent group admin
id username

Fix — remove from sudo group:
deluser username sudo

Verify:
id username  ← sudo should not appear in groups
