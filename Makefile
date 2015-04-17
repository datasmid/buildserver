install:
	ansible-playbook -K -v -i ansible.ini -l local install.yml

clean:
	rm -rf roles/bbaassssiiee.commoncentos/
	rm -rf roles/bbaassssiiee.artifactory/
	rm -rf roles/bbaassssiiee.sonar/
	rm -rf roles/geerlingguy.java/
	rm -rf roles/hudecof.tomcat/
	rm -rf roles/hullufred.nexus/
	rm -rf roles/pcextreme.mariadb/

up:
	vagrant halt
	vagrant up --provision

deploy: 
	ansible-playbook -vv -i ansible.ini -l test deploy.yml

setup:
	vagrant destroy -f test
	vagrant up --provision test

test: clean install setup deploy
