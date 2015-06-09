@echo off

REM If you used the stand Cygwin installer this will be C:\cygwin64
set CYGWIN=C:\cygwin64
set VAGRANT_NO_COLOR=true

REM HOME should here be the path to the trunk.
REM Example: set HOME=/cygdrive/c/work/github/buildserver
set HOME=%PWD%
set PATH=%CYGWIN%\bin;%PATH%
REM You can switch this to work with bash with %CYGWIN%\bin\bash.exe
set SH=%CYGWIN%\bin\bash.exe


REM vagrant working directory cd to current script dir:   cd  %~dp0 
set VAGRANT_CWD= %~dp0 
echo %VAGRANT_CWD%

"%SH%" -c "export ANSIBLE_SSH_ARGS='-o ControlMaster=no' && cd ${VAGRANT_CWD} && export HOME=%HOME% && export PATH=/usr/bin:$PATH && /bin/ansible-playbook `echo %* | sed -E 's#(.*\-\-private-key=)[^ ]*(.*)#\1~/private_key\2#'`"
REM "%SH%" -c "export ANSIBLE_SSH_ARGS='-o ControlMaster=no'  && export PATH=/usr/bin:$PATH && /bin/ansible-playbook `echo %* | sed -E 's#(.*\-\-private-key=)[^ ]*(.*)#\1~/private_key\2#'`"

@echo off
