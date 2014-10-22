#
# Create Sonar database and user.
#
# Command: mysql -u root -p < create_database.sql
#

CREATE DATABASE IF NOT EXISTS sonar CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '{{sonar.jdbc.username}}' IDENTIFIED BY '{{sonar.jdbc.password}}';
GRANT ALL ON sonar.* TO '{{sonar.jdbc.username}}'@'%' IDENTIFIED BY '{{sonar.jdbc.password}}';
GRANT ALL ON sonar.* TO '{{sonar.jdbc.username}}'@'localhost' IDENTIFIED BY '{{sonar.jdbc.password}}';
FLUSH PRIVILEGES;
