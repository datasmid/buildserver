# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  # Prefer VirtualBox before VMware Fusion
  config.vm.provider "virtualbox"
  config.vm.provider "vmware_fusion"

  config.vm.box = "chef/centos-6.6"
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://atlas.hashicorp.com/chef/boxes/centos-6.6"
  config.vm.box_check_update = false

  # disable guest additions
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

  
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", 4096, "--natnet1", "172.16.1/24"]
    vb.gui = false
  end

 config.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "ansible.ini"
    ansible.playbook = "provision.yml"
    ansible.verbose = "vv"
    ansible.host_key_checking = "false"
  end

  config.vm.define :dev,  primary: true do |dev_config|
    dev_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", 4096, "--natnet1", "172.16.1/24"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"  ]
      vb.name = "dev"
      vb.gui = false
    end
    
    dev_config.vm.provider "vmware_fusion" do |vmware|
      vmware.gui = false
      vmware.vmx["memsize"] = "4096"
      vmware.vmx["numvcpus"] = "2"
    end
    # To access this host use: 'vagrant ssh dev' 
    dev_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2222, auto_correct: true
    
    # This host only network for use of Apache as a reverse proxy.
    dev_config.vm.network "private_network", ip: "192.168.10.16", :netmask => "255.255.255.0",  auto_config: true
    
    # MariaDB
    # dev_config.vm.network "forwarded_port", guest: 3306, host: 3306, auto_correct: true 
    
    # HTTPS for reverse proxy
    dev_config.vm.network "forwarded_port", guest: 443, host: 8443, auto_correct: true 
    # Artifactory
    #dev_config.vm.network "forwarded_port", guest: 8081, host: 8081, auto_correct: true
    # Nexus
    #dev_config.vm.network "forwarded_port", guest: 8082, host: 8082, auto_correct: true
    # Sonar
    # dev_config.vm.network "forwarded_port", guest: 9000, host: 9000, auto_correct: true 
  end

  config.vm.define :test, autostart: false do |test_config|
    test_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", 4096, "--natnet1", "172.16.1/24"]
      vb.gui = false
    end
    test_config.vm.network "private_network", ip: "192.168.10.18", :netmask => "255.255.255.0",  auto_config: true
    test_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2223, auto_correct: true
    test_config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
    test_config.vm.provider :virtualbox do |v|
        v.name = "test"
    end
  end
end
