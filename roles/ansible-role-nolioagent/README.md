Ansible Nolio agent
=========

Ansible role to install the CA RA Nolio agent (on linux).
Insprired by: https://communities.ca.com/docs/DOC-231149229

Requirements
------------

CA Release Automation is commercially licensed software. A Nolio instance needs to be configured and resolvable. The agent software is downloaded from that instance.

Role Variables
--------------
use {{ noliohost }} to set the DNS name of the Nolio instance.
use {{ nac_ip }} to set the ip

nolio_execution_name: nolio
nolio_execution_port: 6600
nolio_nimi_port: 6600
nolio_nimi_secured: false
cara_file: nolio_agent_linux_5_0_2_b78.sh

this is for the Linux installer

Dependencies
------------



Example Playbook
----------------

---
- name: 'run ad-hoc playbook'
  hosts: target
  remote_user: vagrant
  sudo: yes
  gather_facts: yes

  pre_tasks:
    - name: 'add "target" in /etc/hosts file'
      lineinfile: dest=/etc/hosts regexp='{{ nac_ip }}'
              line='{{ nac_ip }}   nolio'
              state=present
  roles:
    - ansible-role-nolioagent


License
-------
MIT

Author Information
------------------
@bbaassssiiee
