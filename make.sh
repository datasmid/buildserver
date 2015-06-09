#!/usr/bin/env bash
#simple script to run make and  keep the log.
export VAGRANT_DEFAULT_PROVIDER=virtualbox

#Optional: Disable colors for log files.
#export VAGRANT_NOCOLOR=true
#export ANSIBLE_NOCOLOR=1

make  2>&1 | tee log 

#Remove color codes from log.
sed -r -i  "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" log
#eof
