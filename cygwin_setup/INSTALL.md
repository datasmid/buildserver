
#Provisioning using Windows and cygwin#


Versions|
------------ |
Vagrant 1.7.2 |
Cygwin 2.0.2(0.287/5/3)  |
Windows 7 |


##Windows##
1. Install cygwin
Manual use the supplied the cygwin_install. cmd file.
Verify you have the packages as listed in the appendix, actual versions may vary.
```
cygcheck -c
```
2. Set windows **user** environment variable  to point to your cygwin home (assumes it is on c:\cygwin64)
```
CYGHOME=C:\cygwin64\home\%USERNAME%
VAGRANT_HOME=C:\cygwin64\home\%USERNAME%\vagrant.d
```
3. Windows installations:

  1. Use a vagrant windows installer.

4.Restart windows


##Cygwin:##
--------------------


1. Prepare
(you start of in you $HOME)
```
If you have not setup ssh yet:
	mkdir .ssh
	ssh-keygen -t rsa 
	
mkdir vagrant.d
```
2. Bash profile:
Change your .bash_profle to set some environment variables, see the example here in your $HOME dir.

3. Files

Install vagrant/ansible command wrappers for windows:
Copy the .cmd files to	its parent directory (the directory where ansible.cfg and Vagrantfile is located). 

4. Git clone :
	git clone https://github.com/bbaassssiiee/buildserver (make a directory first)
```
chmod 600 ansible.ini
chod 660 requirements.yml
chmod ug+x roles
```

5. Python packages:
```
	pip install pyyaml
	pip install ansible
	pip install Runner
	pip install Jinja2
```

6. Edit the hosts file of  windows, do not edit it from cygwin as it is a symlink.

```
	#       127.0.0.1       localhost
  #       ::1             localhost
        192.168.10.16   dev
        192.168.10.18   target
        192.168.10.18   test
		
		
7. Allow ansible to connect to boxes as user vagrant:
   Copy the delivered keys  from within the pki directory to your own .ssh directory.


	
Mapping:
vagrant.pub ->id_rsa
vagrant.rsa ->id_rsa_pub


```
Links:<br>
	https://github.com/bbaassssiiee/buildserver<br>
	https://github.com/kroonwijk/buildserver/tree/master/windows<br>
	https://gist.github.com/maurizi


APPENDIX:
==================================================================
A): Example installation cygwin and python packages:


pip list:
```
$ pip list
ansible (1.9.1)
ecdsa (0.13)
Jinja (1.2)
Jinja2 (2.7.3)
MarkupSafe (0.23)
paramiko (1.15.2)
pip (7.0.3)
pyaml (15.5.7)
pycrypto (2.6)
PyYAML (3.11)
Runner (1.1)
setuptools (15.2)
six (1.9.0)
```

cygcheck -v:

```
Package                  Version                          Status
_autorebase              001002-1                         OK
_update-info-dir         00428-1                          OK
alternatives             1.3.30c-10                       OK
base-cygwin              3.8-1                            OK
base-files               4.2-3                            OK
bash                     4.3.33-1                         OK
bash-completion          1.3-1                            OK
binutils                 2.25-1                           OK
bzip2                    1.0.6-2                          OK
ca-certificates          2.4-1                            OK
coreutils                8.23-4                           OK
csih                     0.9.8-6                          OK
curl                     7.42.1-1                         OK
cygrunsrv                1.62-1                           OK
cygutils                 1.4.14-1                         OK
cygwin                   2.0.2-1                          OK
cygwin-devel             2.0.2-1                          OK
dash                     0.5.8-3                          OK
diffutils                3.3-2                            OK
editrights               1.03-1                           OK
file                     5.22-2                           OK
findutils                4.5.12-1                         OK
gawk                     4.1.3-1                          OK
gcc-core                 4.9.2-3                          OK
gcc-g++                  4.9.2-3                          OK
getent                   2.18.90-4                        OK
git                      2.1.4-1                          OK
git-completion           2.1.4-1                          OK
git-email                2.1.4-1                          OK
grep                     2.21-2                           OK
groff                    1.22.3-1                         OK
gzip                     1.6-1                            OK
hostname                 3.13-1                           OK
info                     5.2-3                            OK
ipc-utils                1.0-2                            OK
less                     458-2                            OK
libargp                  20110921-2                       OK
libatomic1               4.9.2-3                          OK
libattr1                 2.4.46-1                         OK
libblkid1                2.25.2-2                         OK
libbz2_1                 1.0.6-2                          OK
libcloog-isl4            0.18.0-2                         OK
libcom_err2              1.42.12-2                        OK
libcrypt0                1.1-1                            OK
libcurl4                 7.42.1-1                         OK
libdb5.3                 5.3.21-1                         OK
libedit0                 20130712-1                       OK
libexpat1                2.1.0-3                          OK
libffi6                  3.2.1-1                          OK
libgcc1                  4.9.2-3                          OK
libgdbm4                 1.11-1                           OK
libgmp10                 6.0.0a-2                         OK
libgnutls28              3.2.21-1                         OK
libgomp1                 4.9.2-3                          OK
libgssapi_krb5_2         1.13.2-1                         OK
libguile17               1.8.8-1                          OK
libhogweed2              2.7-2                            OK
libiconv                 1.14-3                           OK
libiconv2                1.14-3                           OK
libidn11                 1.29-1                           OK
libintl8                 0.19.4-1                         OK
libisl10                 0.11.1-2                         OK
libk5crypto3             1.13.2-1                         OK
libkrb5_3                1.13.2-1                         OK
libkrb5support0          1.13.2-1                         OK
libltdl7                 2.4.6-1                          OK
liblzma5                 5.2.1-1                          OK
libmetalink3             0.1.2-1                          OK
libmpc3                  1.0.3-1                          OK
libmpfr4                 3.1.2-2                          OK
libncursesw10            5.9-20150516-1                   OK
libnettle4               2.7-2                            OK
libopenldap2_4_2         2.4.40-2                         OK
libopenssl100            1.0.2a-1                         OK
libp11-kit0              0.22.1-1                         OK
libpcre1                 8.37-1                           OK
libpipeline1             1.4.0-1                          OK
libpopt0                 1.16-1                           OK
libquadmath0             4.9.2-3                          OK
libreadline7             6.3.8-1                          OK
libsasl2_3               2.1.26-9                         OK
libsmartcols1            2.25.2-2                         OK
libsqlite3_0             3.8.10.2-1                       OK
libssh2_1                1.5.0-1                          OK
libssp0                  4.9.2-3                          OK
libstdc++6               4.9.2-3                          OK
libtasn1_6               4.4-1                            OK
libuuid-devel            2.25.2-2                         OK
libuuid1                 2.25.2-2                         OK
libwrap0                 7.6-22                           OK
libyaml-devel            0.1.6-2                          OK
libyaml0_2               0.1.6-2                          OK
login                    1.11-1                           OK
lynx                     2.8.7-2                          OK
make                     4.1-1                            OK
man-db                   2.7.1-1                          OK
mintty                   1.2-beta1-1                      OK
openssh                  6.8p1-1                          OK
openssl                  1.0.2a-1                         OK
p11-kit                  0.22.1-1                         OK
p11-kit-trust            0.22.1-1                         OK
perl                     5.14.4-3                         OK
perl-Authen-SASL         2.16-1                           OK
perl-Digest-HMAC         1.03-4                           OK
perl-Error               0.17023-1                        OK
perl-IO-Socket-SSL       2.015-1                          OK
perl-MailTools           2.12-1                           OK
perl-Net-SMTP-SSL        1.01-1                           OK
perl-Net-SSLeay          1.68-1                           OK
perl-TimeDate            2.30-1                           OK
perl_autorebase          5.14.4-3                         OK
perl_base                5.14.4-3                         OK
popt                     1.16-1                           OK
python                   2.7.10-1                         OK
python-crypto            2.6-1                            OK
python-paramiko          1.15.2+20150204+gitbdc60c3-2     OK
python-setuptools        15.2-1                           OK
python-six               1.9.0-1                          OK
rebase                   4.4.1-1                          OK
rsync                    3.1.1-1                          OK
run                      1.3.3-1                          OK
sed                      4.2.2-3                          OK
tar                      1.28-1                           OK
terminfo                 5.9-20150516-1                   OK
tzcode                   2014j-1                          OK
util-linux               2.25.2-2                         OK
vim-minimal              7.4.729-2                        OK
w32api-headers           3.3.0-2                          OK
w32api-runtime           3.3.0-1                          OK
wget                     1.16.3-1                         OK
which                    2.20-2                           OK
windows-default-manifest 6.4-1                            OK
xz                       5.2.1-1                          OK
zlib0                    1.2.8-3                          OK
zsh                      5.0.7-1                          OK
```
