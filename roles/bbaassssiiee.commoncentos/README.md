Common Centos
=========

This role provisions a simple Centos box hosted by Hashicorp into Virtualbox.

Requirements
------------
Internet
Vagrant+Virtualbox
The EPEL Yum repository will be configured in the guest VM.

This role wast tested with these boxes:

https://atlas.hashicorp.com/chef/boxes/centos-6.5
https://atlas.hashicorp.com/chef/boxes/centos-6.6

Role Variables
--------------
    {{inventory\_hostname}} 
is used in the VM to set the hostname in conjunction with
    {{ansible\_eth0.ipv4.address}}

defaults/main.yml declares 2 variables:

    {{yum\_packages}} 
is a list of RPM's that will be installed. It defaults to:

    yum_packages:
       - python-httplib2
       - unzip

The var {{dns\_nameserver}} defaults to 8.8.8.8 (hosted by Google)


Dependencies
------------


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: vagrant
      roles:
         - { role: bbaassssiiee.commoncentos }

License
-------

BSD, MIT

Author Information
------------------
http://twitter.com/bbaassssiiee
https://github.com/bbaassssiiee/commoncentos.git

