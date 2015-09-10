# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
$MEMSIZE=1024

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # The ordering of these 2 lines expresses a preference for a hypervisor
  config.vm.provider "virtualbox"
  config.vm.provider "vmware_fusion"

  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"
  config.ssh.forward_agent = false
  config.ssh.insert_key = false

  # Timeouts
  config.vm.boot_timeout = 600
  config.vm.graceful_halt_timeout=100


  config.vm.define :nolio,  primary: true do |nolio_config|
    nolio_config.vm.box = "cara"
    nolio_config.vm.boot_timeout = 60
    nolio_config.vm.box_url = "boxes/cara.box"
    nolio_config.vm.box_check_update = false
    nolio_config.vm.network :private_network, ip: "192.168.10.36"
    nolio_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2236, auto_correct: true
    nolio_config.vm.network :forwarded_port, guest:8080, host:8080, auto_correct: true

    nolio_config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "#$MEMSIZE"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"  ]
      vb.customize ["modifyvm", :id, "--macaddress2", "4ca63b073f36"]
      vb.name = "cara"
      vb.gui = false
    end

    nolio_config.vm.provider "vmware_fusion" do |vmware|
      vmware.gui = true
      vmware.vmx["memsize"] = "#$MEMSIZE"
      vmware.vmx["numvcpus"] = "2"
    end
  end
end
