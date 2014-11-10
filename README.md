buildserver
===========
*Java, Ant, Maven, Gradle, Jenkins, Sonar, Nexus, Artifactory with PostgreSQL 9.3 as database.*

This build server on centos is provisioned with Vagrant and Ansible. 
Plugins for Jenkins and Sonar are provisioned from specs in roles/jenkins/vars/main.yml and roles/sonar/vars/main.yml.

requirements
============
*A Mac with VirtualBox, Vagrant, and Ansible*

http://download.virtualbox.org/virtualbox/4.3.16/VirtualBox-4.3.16-95972-OSX.dmg

https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5.dmg

brew install ansible



getting started
===============
git clone https://github.com/datasmid/buildserver

vagrant up
