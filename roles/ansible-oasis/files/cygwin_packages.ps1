# *******************************************************************
# cygwin_ansible
# Version: Beta 2015/07/13
#
# *******************************************************************

#REQUIRES -Version 2.0

<#
.SYNOPSIS
    Script to install cygwin extras+ansible+vagrant on a windows (desktop) pc.
.DESCRIPTION
    The scripts uses chocolatey to install cygwin.
	Then we use cyg-get to install additional cygwin packages.
	It adds required python packages using the python package manager.

#>

#Variables
$choco_exe ='c:\ProgramData\chocolatey\bin\choco.exe'

#Arrays
$cyg_packages=@(
"bash-completion           ",
"binutils                  ",
"csih                      ",
"curl                      ",
"cygutils                  ",
"cygwin                    ",
"cygwin-devel              ",
"diffutils                 ",
"gcc-core                  ",
"gcc-g++                   ",
"getent                    ",
"git                       ",
"git-completion            ",
"git-email                 ",
"make                      ",
"openssh                   ",
"openssl                   ",
"python                    ",
"python-crypto             ",
"python-paramiko           ",
"python-setuptools         ",
"python-six                ",
"rsync                     ",
"w32api-headers            ",
"w32api-runtime            ",
"wget                      ",
"which                     ",
"windows-default-manifest  "
)

# ----------------------------------------------------
# MAIN
# ----------------------------------------------------

#Cygwin Setup

#Install packages using Cyg-get for choco where not already installed.
Invoke-Expression -Command "powershell -File C:\ProgramData\chocolatey\lib\cyg-get\tools\cyg-get.ps1 install $cyg_packages -noadmin"  | Out-Null
