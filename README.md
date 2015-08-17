README:


Buildserver
===========
This is a complete development environment provisioned with Ansible+Vagrant.

The build server on Centos is provisioned with Vagrant and Ansible. It uses several roles published on http://galaxy.ansible.com.
**Java, Ant, Maven, Gradle, Jenkins, Sonar, Nexus, Artifactory with MariaDB as database.**
It comes fully configure with the example project (game-of-life) of the book "Jenkins, the Definitive Guide". That is an [open source book](http://www.wakaleo.com/books/jenkins-the-definitive-guide).
Plugins for Jenkins and Sonar are provisioned from specs in roles/jenkins/vars/main.yml and roles/sonar/vars/main.yml.

**Tomcat+PostgreSQL** are deployed on a separate VM to mimic production.

**Windows 7 IE 10** is used for post-deployment testing.

Requirements
============

 [VirtualBox](http://download.virtualbox.org/virtualbox/4.3.18/)

 [Vagrant](https://dl.bintray.com/mitchellh/vagrant/)

 [Chocolatey](https://chocolatey.org) (on windows only)

XCode on mac only

Ansible
=======
On Mac run:

`brew install ansible`

On RedHat/Fedora/Centos Linux:

`yum install ansible`

On Windows You can install Ansible & Ansible with Cygwin using this
[Powershell script](https://github.com/Hruodland/cygvagans)
The BAT files will be copied to C:\Hashicorp\bin


Networking
==========
Add these to /etc/hosts or \WINDOWS\SYSTEM32\drivers\etc\hosts

192.168.10.16 dev
192.168.10.18 target
192.168.10.28 lab
192.168.10.36 nolio
192.168.10.40 windows

getting started
===============
    git clone https://github.com/bbaassssiiee/buildserver
    cd buildserver
    make install
    vagrant up

Connect to the buildserver at the host-only address http://192.168.10.16 (you can set that address in the Vagrantfile)

development
===============
Please use the github issue tracker. Feature requests, bug reports, etc, should all be opened as GitHub tickets.
Pull-requests should not contain any merges or merge-conflicts. In general for each change fork the repository, make changes, and submit a specific pull-request.
