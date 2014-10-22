# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.box = "chef/centos-6.5"
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://vagrantcloud.com/chef/centos-6.5"

  # disable guest additions
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true 
  config.vm.network "forwarded_port", guest: 9000, host: 9000, auto_correct: true 
  
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048]
    vb.name = "devhost"
    vb.gui = false
  end

 config.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "ansible.ini"
    ansible.playbook = "provision.yml"
#    ansible.verbose = "v"
    ansible.host_key_checking = "false"
  end

end
