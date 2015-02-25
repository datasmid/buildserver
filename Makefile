install:
	ansible-playbook -v -i ansible.ini -l local install.yml

clean:
	vagrant destroy -f

up:
	vagrant up
