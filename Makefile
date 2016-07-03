VAGRANT_DEFAULT_PROVIDER=virtualbox
export ANSIBLE_SSH_ARGS='-o ControlMaster=no'
default: all


.PHONY: help
help:
	@echo "General tasks:"
	@echo "make  (all)   -builds dev target nolio windows virtual machines"
	@echo "               all: clean setup install deploy"
	@echo "make test     -test dev target nolio windows virtual machines"
	@echo "-------------------------------------------------------------"
	@echo "make clean    -Cleanup vm's and  ansible roles"
	@echo "make addboxes -Run once to 'vagrant box add' the 2 from ./boxes/"
	@echo "make setup    -Setup ansible roles and python packages"
	@echo "make install  -Install the virtual machines only"
	@echo "make build    -Build the application game of life"
	@echo "make deploy   -Deploy the application game of life to target"

.PHONY: setup
setup:
	@echo Install Ansible galaxy roles and dependent python packages.
	ansible-galaxy install -p ./roles --force --role-file requirements.yml
	@echo Installing galaxy roles
	chmod 644 ansible.ini
	ansible-playbook -vv -i ansible.ini -l local install.yml
	@echo Installing python extensions
	pip install --upgrade -r requirements.txt

.PHONY: addboxes
addboxes:
	vagrant box add -f -name nolio boxes/nolio.box
	vagrant box add -f -name windows boxes/windows.box

.PHONY: install
install: setup
	@echo Bring up 2 virtual machines:** 'dev' the CI server, and 'target' the Tomcat server
	vagrant up --no-provision
	@echo **Run the provisioner**
	ansible-playbook -l dev:target provision.yml
	@echo **Install Docker on target too**
	ansible-playbook -l target playbook.yml
	@echo **Bring up the windows 7 VM, and provision it:**
# Bring nolio down, otherwise with 8G windows box will be set in guruMeditation mode if memory runs out ..
	vagrant halt nolio || true
	vagrant up --no-provision windows
	ansible-playbook -l windows provision.yml

.PHONY: build
build:
	@echo Triggers build jobs Jenkins on [dev].
	ansible-playbook -vv -i ansible.ini -l dev build.yml

.PHONY: cleanroles
cleanroles:
	rm -rf roles/bbaassssiiee.commoncentos/
	rm -rf roles/bbaassssiiee.artifactory/
	rm -rf roles/bbaassssiiee.sonar/
	rm -rf roles/ansible-ant/
	rm -rf roles/ansible-maven/
	rm -rf roles/ansible-oasis-maven/
	rm -rf roles/geerlingguy.java/
	rm -rf roles/hudecof.tomcat/
	rm -rf roles/hullufred.nexus/
	rm -rf roles/pcextreme.mariadb/
	rm -rf roles/briancoca.oracle_java7
	rm -rf roles/ansible-selenium-role
	rm -rf roles/windows-selenium-role
	rm -rf roles/ferhaty.jenkins-slave
	rm -rf roles/ansible-jenkins-slave
	rm -rf roles/ansible-role-nolioagent

.PHONY: destroy
destroy:
	@echo Destroys virtual images
	vagrant destroy -f dev
	vagrant destroy -f nolio
	vagrant destroy -f target
	vagrant destroy -f windows

.PHONY: clean
clean: cleanroles destroy

.PHONY: deploy
deploy:
	ansible-playbook -vv -i ansible.ini -l target deploy.yml



.PHONY: smoketest
smoketest:
	ansible-playbook -vv -i ansible.ini -l dev:target smoketest.yml
.PHONY: webtest
webtest:
	ansible-playbook -vv -i ansible.ini -l target webtest.yml
.PHONY: test
test: smoketest webtest


.PHONY: all
all: clean setup install deploy

dev.box:
	vagrant halt dev
	vagrant package --base dev --output boxes/dev.box

boxes/target.box:
	vagrant halt target
	vagrant package --base target --output boxes/target.box
boxes/test.box:
	vagrant halt test
	vagrant package --base test --output boxes/test.box
boxes/windows.box:
	vagrant halt windows
	vagrant package --base windows --output boxes/windows.box

.PHONY: boxes
boxes: boxes/dev.box boxes/target.box boxes/test.box boxes/windows.box




