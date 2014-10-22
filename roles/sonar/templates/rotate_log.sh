#!/bin/bash

$SONAR_HOME/bin/linux-x86-64/sonar.sh stop
rm -f $SONAR_HOME/logs/sonar.log.gz
rm -f $SONAR_HOME/logs/profiling.log.gz
gzip $SONAR_HOME/logs/sonar.log
gzip $SONAR_HOME/logs/profiling.log
$SONAR_HOME/bin/linux-x86-64/sonar.sh start
