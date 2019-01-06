VAGRANT_DEFAULT_PROVIDER=virtualbox
export ANSIBLE_SSH_ARGS='-o ControlMaster=no'
export PYCURL_SSL_LIBRARY=openssl
export LDFLAGS=-L/usr/local/opt/openssl/lib
export CPPFLAGS=-I/usr/local/opt/openssl/include

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

.venv:
	which virtualenv || echo "please install python2 virtualenv, or run 'vagrant up'"
	virtualenv .venv
	( . .venv/bin/activate && pip install --upgrade --ignore-installed -r requirements.txt )

.PHONY: roles
roles: .venv
	@echo Install Ansible galaxy roles and dependent python packages.
	rm -rf galaxy_roles
	( . .venv/bin/activate && ansible-playbook -c local galaxy_import.yml )

.PHONY: trust
trust: .venv
	@(. .venv/bin/activate || echo "run 'make install' first" )
	@( . .venv/bin/activate && ./trust_me.yml )

.PHONY: setup
setup: roles trust

.PHONY: myself
myself: .venv
	( . .venv/bin/activate && ansible-playbook -b -K -i inventories/local -l build provision.yml -vv )

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
	( . .venv/bin/activate && ansible-playbook -vv -l build_master build.yml )

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
	( . .venv/bin/activate && ansible-playbook -vv -l target deploy.yml )

.PHONY: smoketest
smoketest:
	( . .venv/bin/activate && ansible-playbook -vv -l build_master:target smoketest.yml )
.PHONY: webtest
webtest:
	( . .venv/bin/activate && ansible-playbook -vv -l target webtest.yml )
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
