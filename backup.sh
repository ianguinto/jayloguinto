#!/bin/sh
echo "backing up dump-backup has successfully done"|mailx -s "DUMP" toro.ian.guinto@gmail.com
tar -czf /opt/dump-backup/backup_$(date +%Y-%m-%d).tar -C /var/lib/mysql/ important_files

#!/bin/sh
echo "backing up dump-backup has successfully done"|mailx -s "FULL" toro.ian.guinto@gmail.com
tar -czf /opt/full-backup/fullbackup_$(date +%Y-%m-%d).tar -C /opt/ dump-backup

#!/bin/sh
echo "backing up dump-backup has successfully done"|mailx -s "INCREMENTAL" toro.ian.guinto@gmail.com
tar -czf /opt/incremental-backup/inc-backup_$(date +%Y-%m-%d).tar -C /opt/ dump-backup
