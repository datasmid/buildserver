#!/bin/bash -e
mysqldump -u root sonar > /home/sonar_backup/{{sonar.backup.filename}}.sql
cd /home/sonar_backup && gzip {{sonar.backup.filename}}.sql
scp -i ~/.ssh/backup /home/sonar_backup/{{sonar.backup.filename}}.sql.gz {{sonar.backup.username}}@{{sonar.backup.hostname}}:sonar_backups 
rm -f /home/sonar_backup/{{sonar.backup.filename}}.sql.gz
