roles:
	ansible-playbook -v -i ansible.ini -l local install.yml

clean:
    rm -rf roles
	vagrant destroy -f

up:
	vagrant up
