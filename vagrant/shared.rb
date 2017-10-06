def create_vm(config, options = {})

  name = options.fetch(:name, "node")
  id = options.fetch(:id, 1)
  vm_name = "%s-%02d" % [name, id]

  memory = options.fetch(:memory, 2048)
  cpus = options.fetch(:cpus, 1)

  config.vm.define vm_name do |config|
    config.vm.box = "centos/7"
    config.vm.hostname = vm_name

    private_ip = "192.0.2.111"
    config.vm.network :private_network,
      :libvirt__network_name => "centos-private",
      ip: private_ip, netmask: "255.255.255.128"

    public_ip = "192.0.2.211"
    config.vm.network :private_network,
      :libvirt__network_name => "centos-public",
      ip: public_ip, netmask: "255.255.255.128"

    config.vm.provider :virtualbox do |vb|
      vb.memory = memory
      vb.cpus = cpus
    end
    config.vm.provider :libvirt do |lv|
      lv.management_network_address = "192.168.122.0/24"
      lv.management_network_name = "default"
      lv.memory = memory
      lv.cpus = cpus
    end
  end
end
