VAGRANT_DEFAULT_PROVIDER=virtualbox
default: all

.PHONY: install
install:
	@echo installing galaxy roles
	ansible-playbook -vv -i ansible.ini -l local install.yml
	@echo installing python extensions
	pip install --upgrade -r requirements.txt

.PHONY: prepare
prepare:
	vagrant up --no-provision dev
	vagrant up --no-provision target
#	vagrant up --no-provision testclient
#	vagrant up --no-provision windows

.PHONY: clean
clean:
	rm -rf roles/bbaassssiiee.commoncentos/
	rm -rf roles/bbaassssiiee.artifactory/
	rm -rf roles/bbaassssiiee.sonar/
	rm -rf roles/ansible-ant/
	rm -rf roles/ansible-eclipse/
	rm -rf roles/ansible-maven/
	rm -rf roles/ansible-oasis-maven/
	rm -rf roles/geerlingguy.java/
	rm -rf roles/hudecof.tomcat/
	rm -rf roles/hullufred.nexus/
	rm -rf roles/pcextreme.mariadb/
	rm -rf roles/briancoca.oracle_java7

.PHONY: up
up:
	vagrant up --no-provision dev
	vagrant provision dev
	ansible-playbook -vv -i ansible.ini -l dev build.yml


.PHONY: deploy
deploy:
	vagrant up --no-provision target
	vagrant provision target
	ansible-playbook -vv -i ansible.ini -l target deploy.yml
	ansible-playbook -vv -i ansible.ini -l all webtest.yml


.PHONY: testclient
testclient:
	vagrant up testclient
	vagrant provision testclient
	vagrant halt testclient

.PHONY: smoketest
smoketest:
	ansible-playbook -vv -i ansible.ini -l all smoketest.yml
.PHONY: webtest
webtest:
	ansible-playbook -vv -i ansible.ini -l target webtest.yml
.PHONY: test
test: smoketest webtest

.PHONY: all
all: install up deploy smoketest webtest

dev.box:
	vagrant halt dev
	vagrant package --base dev --output boxes/dev.box

boxes/target.box:
	vagrant halt target
	vagrant package --base target --output boxes/target.box
boxes/testclient.box:
	vagrant halt testclient
	vagrant package --base testclient --output boxes/testclient.box
boxes/windows.box:
	vagrant halt windows
	vagrant package --base windows --output boxes/windows.box

.PHONY: boxes
boxes: boxes/dev.box boxes/target.box boxes/testclient.box boxes/windows.box

import:
	vagrant box add -f -name dockpack/centos6 boxes/target.box
	vagrant box add -f -name ubuntu14 boxes/testclient.box
	vagrant box add -f -name chef/centos-6.6 boxes/dev.box


### Babun is a linux-like environment on windows
### http://babun.github.io
### use of ansible under babun is experimental and still broken

### See install instructions in cygwin-setup for a working alternative.

.PHONY: babun
babun:
	pact install python python-paramiko python-crypto gcc-g++ wget openssh python-setuptools
	@echo 'export PYTHONHOME=/usr' >> ~/.zshrc
	@echo 'export export PYTHONPATH=/usr/lib/python2.7' >> ~/.zshrc
	@echo 'export PYTHONHOME=/usr' >> ~/.bash_profile
	@echo 'export export PYTHONPATH=/usr/lib/python2.7' >> ~/.bash_profile

	export PYTHONHOME=/usr
	export PYTHONPATH=/usr/lib/python2.7
	python /usr/lib/python2.7/site-packages/easy_install.py pip
	pip install ansible
	mkdir -p ${HOME}/bin
	cp windows/ansible-playbook.bat ${HOME}/bin
	chmod -x ansible.ini
	chmod a+rw *.*
