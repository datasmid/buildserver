
default: all  
	
.PHONY: install
install:
	ansible-playbook -v -i ansible.ini -l local install.yml

.PHONY: clean
clean:
	rm -rf roles/bbaassssiiee.commoncentos/
	rm -rf roles/bbaassssiiee.artifactory/
	rm -rf roles/bbaassssiiee.sonar/
	rm -rf roles/geerlingguy.java/
	rm -rf roles/hudecof.tomcat/
	rm -rf roles/hullufred.nexus/
	rm -rf roles/pcextreme.mariadb/
	rm -rf roles/Ginsys.omnibus-gitlab/

.PHONY: up
up:
	vagrant halt dev
	vagrant destroy -f dev
	vagrant up --no-provision dev
	wait
	#Please read INSTALL notes about setting up ssh forwarding.
	ssh-agent
	ssh-add -D
	ssh-add ./.vagrant/machines/dev/virtualbox/private_key
	vagrant provision dev

.PHONY: deploy
deploy: 
	vagrant halt test
	vagrant up --no-provision test 
	wait
	ssh-agent
	ssh-add -D
	ssh-add ./.vagrant/machines/test/virtualbox/private_key
	vagrant provision test
	ansible-playbook -vv -i ansible.ini -l test deploy.yml

.PHONY: setup
setup:
	vagrant destroy -f test

.PHONY: test
test: clean install setup deploy

.PHONY: all
all: clean install up setup deploy

