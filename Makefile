VAGRANT_DEFAULT_PROVIDER=virtualbox
export ANSIBLE_SSH_ARGS='-o ControlMaster=no'
default: all


.PHONY: help
help:
	@echo "General tasks:"
	@echo "make setup    -install requirements and generate keys"
	@echo "make mysqlf   -install on centos7"
	@echo "make  (all)   -builds build target windows virtual machines"
	@echo "               all: clean setup install deploy"
	@echo "make test     -test build target win_slave test_slave virtual machines"
	@echo "-------------------------------------------------------------"
	@echo "make clean    -Cleanup vm's and  ansible roles"
	@echo "make addboxes -Run once to 'vagrant box add' the 2 from ./boxes/"
	@echo "make install  -Install the virtual machines only"
	@echo "make build    -Build the application game of life"
	@echo "make deploy   -Deploy the application game of life to target"

.PHONY: setup
setup:
	@echo Install Ansible galaxy roles and dependent python packages.
	pip install -r requirements.txt
	ansible-playbook -c local galaxy_import.yml

.PHONY: myself
myself:
	ansible-playbook -K -i inventories/local -l buildserver provision.yml -vv

.PHONY: addboxes
addboxes:
	vagrant box add -f -name win_slave boxes/windows.box

.PHONY: install
install: setup
	@echo Bring up 2 virtual machines:** 'build_master' the CI server, and 'target'.
	vagrant up --no-provision build_master target
	@echo **Run the provisioner**
	ansible-playbook -l build_master:target provision.yml
	@echo **Install Docker on target too**
	ansible-playbook -l target provision.yml
	@echo **Bring up the windows 7 VM, and provision it:**
	vagrant up --no-provision win_slave
	ansible-playbook -l win_slave provision.yml

.PHONY: build
build:
	@echo Triggers build jobs Jenkins on [build_master].
	ansible-playbook -vv -l build_master build.yml

.PHONY: cleanroles
cleanroles:
	rm -rf roles/base_*
	rm -rf roles/bbaassssiiee.*
	rm -rf roles/ansible-oasis
	rm -rf roles/ansible-nexus
	rm -rf roles/hudecof.tomcat
	rm -rf roles/ansible-selenium-role
	rm -rf roles/windows-selenium-role
	rm -rf roles/ferhaty.jenkins-slave
	rm -rf roles/ansible-jenkins-slave

.PHONY: destroy
destroy:
	vagrant halt build_master
	vagrant halt target
	vagrant halt test_slave
	vagrant halt win_slave
	@echo Destroys virtual images
	vagrant destroy -f build_master
	vagrant destroy -f target
	vagrant destroy -f test_slave
	vagrant destroy -f win_slave

.PHONY: clean
clean: cleanroles destroy

.PHONY: deploy
deploy:
	ansible-playbook -vv -l target deploy.yml

.PHONY: smoketest
smoketest:
	ansible-playbook -vv -l build_master:target smoketest.yml
.PHONY: webtest
webtest:
	ansible-playbook -vv -l target webtest.yml
.PHONY: test
test: smoketest webtest

.PHONY: all
all: clean setup install deploy

build.box:
	vagrant halt build_master
	vagrant package --base build_master --output boxes/build.box

boxes/target.box:
	vagrant halt target
	vagrant package --base target --output boxes/target.box
boxes/test.box:
	vagrant halt test_slave
	vagrant package --base test_slave --output boxes/test.box
boxes/windows.box:
	vagrant halt win_slave
	vagrant package --base win_slave --output boxes/windows.box

.PHONY: boxes
boxes: boxes/build.box boxes/target.box boxes/test.box boxes/windows.box




