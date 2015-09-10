bbaassssiiee.sonar
=========

Sonar is a source-code quality tool.

Requirements
------------

Sonar can use either a MySQL variant, or PostgreSQL, as a database. You should select just one of these using the features.

    features:
      mysql: True
      postgresql: False


Role Variables
--------------

defaults/main.yml and vars/main.yml contain variables. Please change the sonar_password first. For advanced users the sonar_plugins might be interesting.

Dependencies
------------

You can run this role combined with the role pcextreme.mariadb. An implementation with Postgres is possible.

Example Usage
----------------

Refer to a complete build server https://github.com/bbaassssiiee/buildserver

License
-------

BSD

Author Information
------------------

Bas Meijer
@bbaassssiiee
