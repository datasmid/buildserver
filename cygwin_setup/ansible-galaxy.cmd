rem echo off

REM If you used the stand Cygwin installer this will be C:\cygwin64
set CYGWIN=C:\cygwin64
set HOME=%CYGHOME%
set PATH=%CYGWIN%\bin;%PATH%
set VAGRANT_NO_COLOR=true
REM You can switch this to work with bash with %CYGWIN%\bin\bash.exe
set SH=%CYGWIN%\bin\bash.exe

"%SH%" -c "/cygdrive/c/cygwin64/opt/ansible/bin/ansible-galaxy %*"


@echo off
