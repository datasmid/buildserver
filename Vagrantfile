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
    anible_limit = " build"
    ansible.host_key_checking = "false"
  end

  # buildserver
  config.vm.define :build, autostart: true do |build_master|
    build_master.vm.box = "centos/7"
    build_master.vm.box_url = "https://atlas.hashicorp.com/centos/7"
    build_master.vm.box_check_update = false
    build_master.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
    build_master.vm.network "private_network", ip: "192.168.10.28", :netmask => "255.255.255.0",  auto_config: true
    build_master.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2227, auto_correct: true
    build_master.vm.network "forwarded_port", guest: 443, host: 443, auto_correct: true
    build_master.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "4096", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "build"
    end

    build_master.vm.provider "vmware_fusion" do |vmware|
      vmware.gui = false
      vmware.vmx["memsize"] = "#$MEMSIZE"
      vmware.vmx["numvcpus"] = 2
    end
  end

  # target: system under test
  config.vm.define :target, autostart: false do |tartget_slave|
    tartget_slave.vm.box = "dockpack/centos6"
    tartget_slave.vm.box_url = "https://atlas.hashicorp.com/centos/7"
    tartget_slave.vm.box_check_update = true
    tartget_slave.vm.network "private_network", ip: "192.168.10.18", :netmask => "255.255.255.0",  auto_config: true
    tartget_slave.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2226, auto_correct: true

    tartget_slave.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "#$MEMSIZE", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "target"
    end

    tartget_slave.vm.provider "vmware_fusion" do |vmware|
      vmware.gui = false
      vmware.vmx["memsize"] = "#$MEMSIZE"
      vmware.vmx["numvcpus"] = 2
    end
  end

  # testserver: tests the target above
  config.vm.define :test, autostart: false do |test_slave|
    test_slave.vm.box = "ubuntu14"
    test_slave.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    test_slave.vm.network "private_network", ip: "192.168.10.20", :netmask => "255.255.255.0",  auto_config: true
    test_slave.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2224, auto_correct: true
    test_slave.vm.network :forwarded_port, guest:8000, host:8000
    test_slave.vm.provider "vmware_fusion" do |vmware|
      vmware.vmx["memsize"] = "#$MEMSIZE"
      vmware.vmx["numvcpus"] = "2"
    end
    test_slave.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "#$MEMSIZE", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "test"
    end
    test_slave.vm.provider "vmware_fusion" do |vmware|
      vmware.gui = false
      vmware.vmx["memsize"] = "#$MEMSIZE"
      vmware.vmx["numvcpus"] = 2
    end
  end

  # windows: has Exporer for web testing
  config.vm.define :jenkins_windows_slave, autostart: false do |win_slave|
    win_slave.vm.box = "ferhaty/win7ie10winrm"
    win_slave.vm.box_url = "https://atlas.hashicorp.com/ferhaty/boxes/win7ie10winrm"
    win_slave.vm.guest = :windows
    win_slave.vm.communicator = "winrm"
    win_slave.winrm.username = 'vagrant'
    win_slave.winrm.password = 'vagrant'
    win_slave.vm.box_check_update = true
    win_slave.vm.network :private_network, ip: "192.168.10.41"
    win_slave.vm.network :forwarded_port, guest:8000, host:8000
    win_slave.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
    win_slave.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "win_slave"
      vb.customize [
           "modifyvm", :id,
           "--memory", "#$MEMSIZE",
           "--natnet1", "172.16.1/24",
      ]
    end
  end

end
