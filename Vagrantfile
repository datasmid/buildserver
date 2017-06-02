# -*- mode: ruby -*-
# vi: set ft=ruby :

# Check to determine whether we're on a windows or linux/os-x host,
# later on we use this to launch ansible in the supported way
# source: https://stackoverflow.com/questions/2108727/which-in-ruby-checking-if-program-exists-in-path-from-ruby
def which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
            exe = File.join(path, "#{cmd}#{ext}")
            return exe if File.executable? exe
        }
    end
    return nil
end


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
  config.vm.graceful_halt_timeout=30
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root"

  # build_master
  config.vm.define :build_master, autostart: true do |build_master|
    build_master.vm.box = "redesign/centos7"
    build_master.vm.box_url = "https://atlas.hashicorp.com/redesign/centos7"
    build_master.vm.box_check_update = false
    build_master.vm.synced_folder ".", "/vagrant", id: "vagrant-root"
    build_master.vm.network "private_network", ip: "192.168.10.28", :netmask => "255.255.255.0",  auto_config: true
    build_master.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2228, auto_correct: false
#    build_master.vm.network "forwarded_port", guest: 443, host: 8443, auto_correct: true
    build_master.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "4096", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "build_master"
    end
    if which('ansible-playbook')
      build_master.vm.provision "ansible" do |ansible|
        ansible.playbook = "provision.yml"
          ansible.inventory_path = "inventories/vagrant"
          ansible.limit = "build_master"
          ansible.verbose = 'vv'
          ansible.limit = "build_master"
        end
      end
  end

  # testserver: tests the target above
  config.vm.define :blue, autostart: false do |blue|
    blue.vm.box = "redesign/centos7"
    blue.vm.box_url = "https://atlas.hashicorp.com/redesign/centos7"
    blue.vm.network "private_network", ip: "192.168.10.23", :netmask => "255.255.255.0",  auto_config: true
    blue.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2223, auto_correct: false
    blue.vm.network :forwarded_port, guest:8000, host:8000

    blue.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "#$MEMSIZE", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "test"
    end
  end

  config.vm.define :red, autostart: false do |red|
    red.vm.box = "redesign/centos7"
    red.vm.box_url = "https://atlas.hashicorp.com/redesign/centos7"
    red.vm.network "private_network", ip: "192.168.10.24", :netmask => "255.255.255.0",  auto_config: true
    red.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2224, auto_correct: false
    red.vm.network :forwarded_port, guest:8000, host:8000
    red.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "#$MEMSIZE", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "red"
    end
    if which('ansible-playbook')
      red.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/provision.yml"
          ansible.inventory_path = "inventories/vagrant"
          ansible.verbose = 'vv'
          ansible.limit = "red"
        end
      end
  end

  config.vm.define :green, autostart: false do |green|
    green.vm.box = "redesign/centos7"
    green.vm.box_url = "https://atlas.hashicorp.com/redesign/centos7"
    green.vm.box_check_update = true
    green.vm.network "private_network", ip: "192.168.10.25", :netmask => "255.255.255.0",  auto_config: true
    green.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2225, auto_correct: false

    green.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "#$MEMSIZE", "--natnet1", "172.16.1/24"]
      vb.gui = false
      vb.name = "green"
    end
    # If ansible is in your path it will provision from your HOST machine
    # If ansible is not found in the path it will be instaled in the VM and provisioned from there
    if which('ansible-playbook')
      green.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/provision.yml"
          ansible.inventory_path = "inventories/vagrant"
          ansible.verbose = 'vv'
          ansible.limit = "green"
        end
      end
  end

  config.vm.define :win_slave, autostart: false do |win_slave|
    win_slave.vm.box = "ferhaty/win7ie10winrm"
    win_slave.vm.box_url = "https://atlas.hashicorp.com/ferhaty/boxes/win7ie10winrm"
    win_slave.vm.guest = :windows
    win_slave.vm.communicator = "winrm"
    win_slave.winrm.username = 'vagrant'
    win_slave.winrm.password = 'vagrant'
    win_slave.vm.box_check_update = true
    win_slave.vm.network :private_network, ip: "192.168.10.26"
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
