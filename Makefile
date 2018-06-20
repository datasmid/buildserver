VAGRANT_DEFAULT_PROVIDER=virtualbox
export ANSIBLE_SSH_ARGS='-o ControlMaster=no'
default: help


.PHONY: help
help:
	@echo "Beginner tasks:"
	@echo "make setup         -install requirements and generate keys"
	@echo "make myself        -install on centos7"
	@echo "make vagrant       -Install two virtual machines only"
	@echo "make build         -Build the application game of life"
#	@echo "make deploy        -Deploy the application game of life to target"
	@echo "make cleanroles    -Cleanup vm's and  ansible roles"

.PHONY: setup
setup:
	@echo Install Ansible galaxy roles and dependent python packages.
	rm -rf galaxy_roles
#	pip install -r requirements.txt
	ansible-playbook -c local galaxy_import.yml
	./trust_me.yml

.PHONY: myself
myself:
	ansible-playbook -K -i inventories/local -l buildserver provision.yml -vv

.PHONY: addboxes
addboxes:
	vagrant box add -f -name win_slave boxes/windows.box

.PHONY: vagrant
vagrant:
	@echo Bring up vagrant VM:** 'build_master' the CI server
	vagrant up --no-provision build_master
	vagrant provision build_master

.PHONY: build
build:
	@echo Triggers build jobs Jenkins on [build_master].
	ansible-playbook -vv -l build_master build.yml

.PHONY: cleanroles
cleanroles:
	rm -rf galaxy_roles

.PHONY: destroy
destroy:
	@echo halt virtual machines
	vagrant halt build_master
	vagrant halt win_slave
	@echo Destroys virtual machines
	vagrant destroy -f build_master
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
