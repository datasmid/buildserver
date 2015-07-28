README:


buildserver
===========
*Java, Ant, Maven, Gradle, Jenkins, Sonar, Nexus, Artifactory with MariaDB as database.*

This build server on Centos is provisioned with Vagrant and Ansible. It uses several roles published on http://galaxy.ansible.com.

Plugins for Jenkins and Sonar are provisioned from specs in roles/jenkins/vars/main.yml and roles/sonar/vars/main.yml.

It comes fully configure with the example project (game-of-life) of the book "Jenkins, the Definitive Guide".
That is an open source book available at http://www.wakaleo.com/books/jenkins-the-definitive-guide


requirements
============
*Vagrant and Ansible; and VirtualBox or VMWare (Fusion)*

http://download.virtualbox.org/virtualbox/4.3.18/
https://dl.bintray.com/mitchellh/vagrant/

Windows
=======
You can install Ansible with Cygwin using this Powershell script:
https://github.com/alangibson/ansible-cygwin-installer
Place the BAT files somewhere in your Windows %PATH%.


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
    ansible-playbook -v -i ansible.ini -l local install.yml
    pip install --upgrade -r requirements.txt
    vagrant up

Connect to the buildserver at the host-only address http://192.168.10.16 (you can set that address in the Vagrantfile)

development
===============
Please use the github issue tracker. Feature requests, bug reports, etc, should all be opened as GitHub tickets.
Pull-requests should not contain any merges or merge-conflicts. In general for each change fork the repository, make changes, and submit a specific pull-request.
