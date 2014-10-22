#!/bin/bash -e
scp -i ~/.ssh/backup {{sonar.backup.username}}@{{sonar.backup.hostname}}:sonar_backups/{{sonar.restore.filename}}.sql.gz /home/sonar_backup/
cd /home/sonar_backup && gunzip {{sonar.restore.filename}}.sql.gz
mysql -u root  < $HOME/bin/drop_database.sql
mysql -u root  < $HOME/bin/create_database.sql
mysql -u root sonar < /home/sonar_backup/{{sonar.restore.filename}}.sql
rm -f /home/sonar_backup/{{sonar.restore.filename}}.sql
echo 'restored {{sonar.backup.username}}@__sonar.backup.hostname__:sonar_backups/{{sonar.restore.filename}}.sql.gz on __components.sonar.resource.host__'
