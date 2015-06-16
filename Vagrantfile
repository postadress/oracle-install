# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|

  config.vm.box = "puphpet/centos65-x64"
  config.vm.box_url = "https://atlas.hashicorp.com/puphpet/boxes/centos65-x64"
  config.vm.hostname = "localoracle"
  config.vm.network "private_network", type: "dhcp"
  
  ########################################################################
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # Forward Oracle ports and open firewall on Port 1521
  config.vm.network :forwarded_port, guest: 1521, host: 1521
  config.vm.network :forwarded_port, guest: 1158, host: 1158
  config.vm.provision :shell, :inline => "iptables -I INPUT -p tcp --dport 1521 -j ACCEPT"
  config.vm.provision :shell, :inline => "service iptables save"
  ########################################################################
  
  ########################################################################
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id,
                  "--memory", "2048"]
  end
  ########################################################################
    
  ########################################################################
  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
  config.vm.provision :shell, :path => "install/oracle/installOracleDatabase.sh"
  ########################################################################
    
end
