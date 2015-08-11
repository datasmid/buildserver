@echo off
export ANSIBLE_SSH_ARGS='-o ControlMaster=no'

set CYGWIN=C:\tools\cygwin
set SH=%CYGWIN%\bin\bash.exe

"%SH%" -c "/bin/ansible-playbook %*"
