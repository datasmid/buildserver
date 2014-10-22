#!/bin/bash -e
date
echo 'retrieving backup'
scp -i ~/.ssh/backup {{sonar.backup.username}}@{{sonar.backup.hostname__:sonar_backups/{{sonar.restore.filename}}.sql.gz /home/sonar_backup/
date
echo 'uncompressing'
cd /home/sonar_backup && gunzip {{sonar.restore.filename}}.sql.gz
echo 'prepping sonar database'
mysql -u root  < $HOME/bin/drop_database.sql
mysql -u root  < $HOME/bin/create_database.sql
date
echo 'restoring dump, this might take a while...'
mysql -u root sonar < /home/sonar_backup/{{sonar.restore.filename}}.sql
rm -f /home/sonar_backup/{{sonar.restore.filename}}.sql
date
echo "all done, start it and go to http://`hostname`:9000/setup"
