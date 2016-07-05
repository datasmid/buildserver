# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
$MEMSIZE=1024

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # The ordering of these 2 lines expresses a preference for a hypervisor
  config.vm.provider "virtualbox"
  config.vm.provider "vmware_fusion"

  config.ssh.forward_agent = false
  config.ssh.insert_key = false

  # Timeouts
  config.vm.boot_timeout = 900
  config.vm.graceful_halt_timeout=100

  # Use the Ansible playbook provision.yml to setup the virtual machines.
  config.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "ansible.ini"
    ansible.playbook = "provision.yml"
    ansible.verbose = "vv"
    ansible.host_key_checking = "false"
  end

  # disable guest additions
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

  config.vm.define :dev,  primary: true do |dev_config|
    dev_config.vm.box = "dockpack/centos6"
    dev_config.vm.box_url = "https://atlas.hashicorp.com/dockpack/boxes/centos6"
    dev_config.vm.box_check_update = true
    # This host only network for use of Apache as a reverse proxy.
    dev_config.vm.network "private_network", ip: "192.168.10.16", :netmask => "255.255.255.0",  auto_config: true
    # To access this host use: 'vagrant ssh dev'
    dev_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2222, auto_correct: true
    dev_config.vm.hostname = "dev"
    # HTTPS for reverse proxy
    #dev_config.vm.network "forwarded_port", guest: 443, host: 8443, auto_correct: true

    dev_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "3072", "--natnet1", "172.16.1/24"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"  ]
      vb.name = "buildserver"
      vb.gui = false
    end

    dev_config.vm.provider "vmware_fusion" do |vmware|
      vmware.gui = false
      vmware.vmx["memsize"] = "#$MEMSIZE"
      vmware.vmx["numvcpus"] = "2"
    end
  end

  config.vm.define :target, autostart: false do |target_config|
    target_config.vm.box = "dockpack/centos6"
    target_config.vm.box_url = "https://atlas.hashicorp.com/dockpack/boxes/centos6"
    target_config.vm.box_check_update = true
    target_config.vm.network "private_network", ip: "192.168.10.18", :netmask => "255.255.255.0",  auto_config: true
    target_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2223, auto_correct: true

    target_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "#$MEMSIZE", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "target"
    end

    target_config.vm.provider "vmware_fusion" do |vmware|
      vmware.gui = false
      vmware.vmx["memsize"] = "#$MEMSIZE"
      vmware.vmx["numvcpus"] = 2
    end
  end

  config.vm.define :test, autostart: false do |test_config|
    test_config.vm.box = "ubuntu14"
    test_config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    test_config.vm.network "private_network", ip: "192.168.10.20", :netmask => "255.255.255.0",  auto_config: true
    test_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2224, auto_correct: true
    test_config.vm.network :forwarded_port, guest:8000, host:8000
    test_config.vm.provider "vmware_fusion" do |vmware|
      vmware.vmx["memsize"] = "#$MEMSIZE"
      vmware.vmx["numvcpus"] = "2"
    end
    test_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "#$MEMSIZE", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "test"
    end
    test_config.vm.provider "vmware_fusion" do |vmware|
      vmware.gui = false
      vmware.vmx["memsize"] = "#$MEMSIZE"
      vmware.vmx["numvcpus"] = 2
    end
  end

  config.vm.define :windows, autostart: false do |windows_config|
    windows_config.vm.box = "dockpack/windows"
    windows_config.vm.box_check_update = true
    windows_config.winrm.username = 'IEuser'
    windows_config.winrm.password = 'Passw0rd!'
    windows_config.vm.communicator = "winrm"
    windows_config.vm.box_url = "https://atlas.hashicorp.com/dockpack/boxes/windows"
    windows_config.vm.network :private_network, ip: "192.168.10.40"
    windows_config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
    windows_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "#$MEMSIZE", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "windows"
    end
  end

  config.vm.define :jenkins_windows_slave, autostart: false do |windows_slave_config|
    windows_slave_config.vm.box = "dockpack/windows"
    windows_slave_config.vm.box_check_update = true
    windows_slave_config.winrm.username = 'IEuser'
    windows_slave_config.winrm.password = 'Passw0rd!'
    windows_slave_config.vm.communicator = "winrm"
    windows_slave_config.vm.box_url = "https://atlas.hashicorp.com/dockpack/boxes/windows"
    windows_slave_config.vm.network :private_network, ip: "192.168.10.41"
    windows_slave_config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
    windows_slave_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "#$MEMSIZE", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "jenkins_windows_slave"
    end
  end

  config.vm.define :nolio, autostart: false do |nolio_config|
    nolio_config.vm.box = "nolio"
    nolio_config.vm.boot_timeout = 60
    nolio_config.vm.box_url = "boxes/nolio.box"
    nolio_config.vm.box_check_update = false
    nolio_config.vm.network :private_network, ip: "192.168.10.36"
    nolio_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2236, auto_correct: true
    nolio_config.vm.network :forwarded_port, guest:8080, host:8080, auto_correct: true

    nolio_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"  ]
      vb.customize ["modifyvm", :id, "--macaddress2", "4ca63b073f36"]
      vb.name = "nolio"
      vb.gui = false
    end
  end
  config.vm.define :lab, autostart: false do |lab_config|
    lab_config.vm.box = "chef/centos-7.1"
    lab_config.vm.box_url = "https://atlas.hashicorp.com/chef/boxes/centos-7.1"
    lab_config.vm.box_check_update = false
    lab_config.vm.network "private_network", ip: "192.168.10.28", :netmask => "255.255.255.0",  auto_config: true
    lab_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2227, auto_correct: true
    lab_config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true

    lab_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "3076", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "lab"
    end

    lab_config.vm.provider "vmware_fusion" do |vmware|
      vmware.gui = false
      vmware.vmx["memsize"] = "#$MEMSIZE"
      vmware.vmx["numvcpus"] = 2
    end
  end
end
