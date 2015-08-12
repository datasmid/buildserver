@echo off

set CYGWIN=C:\tools\cygwin
set SH=%CYGWIN%\bin\bash.exe

"%SH%" -c "/cygdrive/c/cygwin64/opt/ansible/bin/ansible-galaxy %*"
