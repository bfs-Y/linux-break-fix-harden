# Drill 07 — ACL audit

Standard ls -la hides ACL entries. Always check with getfacl on sensitive files.

Commands:
getfacl /path/to/file
setfacl -m u:username:rwx /path/to/file  # add ACL entry
setfacl -x u:username /path/to/file      # remove ACL entry
getfacl -R /etc/ 2>/dev/null             # recursive ACL audit

Red flag: any ACL entry on /etc/passwd, /etc/shadow, /etc/sudoers

Example break:
setfacl -m u:daemon:rwx /etc/passwd

Example fix:
setfacl -x u:daemon /etc/passwd
