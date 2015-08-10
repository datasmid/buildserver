# *******************************************************************
# cygwin_ansible
# Version: Beta 2015/07/13
#
# *******************************************************************

#REQUIRES -Version 2.0

<#
.SYNOPSIS
    Script to install ansible on a windows pc.
.DESCRIPTION
	It adds required python packages using the python package manager.

#>

# ----------------------------------------------------
# MAIN
# ----------------------------------------------------

Start-process C:\tools\cygwin\bin\bash.exe -ArgumentList '-c ','/bin/python -m ensurepip' -Wait -NoNewWindow
Start-process C:\tools\cygwin\bin\bash.exe -ArgumentList  '--login', '-c ','/bin/pip install --upgrade -r /tmp/requirements.txt' -Wait -NoNewWindow
Start-process C:\tools\cygwin\bin\bash.exe -ArgumentList  '--login', '-c ','/bin/pip install --upgrade ansible' -Wait -NoNewWindow
