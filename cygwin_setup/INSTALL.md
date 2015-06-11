
#Provisioning using Windows and cygwin#

This solution works without copying .cmd files to other directories.


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

Set in windows environment settings a single user environment variable: VAGRANT_HOME.
Example: C:\work\vagrant.d
This is where vagrant boxes for example will be stored, can be a shared drive.


Run cygcheck -c in cygwin, compare with appendix.

```
2. Windows installations:

  1. Use a vagrant windows installer.

3.Restart windows


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
Change your .bash_profle to set some environment variables, see the example in this directory,
in your $HOME dir of cygwin.


3. Git clone :
	git clone https://github.com/bbaassssiiee/buildserver (make a directory first)
```
chmod 600 ansible.ini
chod 660 requirements.yml
chmod ug+x roles
```

4. Python packages:
```
	pip install pyyaml
	pip install ansible
	pip install Runner
	pip install Jinja2
	
	#smoketests dependency.
	pip install httplib2
```

5. Edit the hosts file of  windows, do not edit it from cygwin as it is a symlink.

```
	#       127.0.0.1       localhost
  #       ::1             localhost
        192.168.10.16   dev
        192.168.10.18   target
        192.168.10.18   test



6. Allow ansible to connect to boxes as user vagrant:
   Copy the delivered keys  from within the pki directory to your own .ssh directory.

Mapping:
vagrant.pub ->id_rsa
vagrant.rsa ->id_rsa_pub


```
Links:<br>
	https://github.com/bbaassssiiee/buildserver<br>
	https://github.com/kroonwijk/buildserver/tree/master/windows<br>
	https://gist.github.com/maurizi
```

APPENDIX:
==================================================================
A): Example installation cygwin and python packages:


pip list: (python package list)
```

$ pip list

ansible (1.9.1)
ecdsa (0.13)
httplib2 (0.9.1)
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

