require 'berkshelf/vagrant'

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # Port 2222 -> 22 is provided for ssh by default
  config.vm.network :forwarded_port, guest: 80, host: 8080
  
  cmd = <<-EOF
    if [ ! `which curl` ]; then
      apt-get install -y curl
    fi

    if [ -d /opt/vagrant_ruby ]; then
      rm -rf /opt/vagrant_ruby
    fi
    
    if [ ! -d /opt/chef ]; then
      curl -L https://www.opscode.com/chef/install.sh | sudo bash
    fi
  EOF
  config.vm.provision :shell, :inline => cmd

  config.vm.provision :chef_solo do |chef|
    chef.data_bags_path = "data_bags"
    chef.cookbooks_path = ["site-cookbooks"]    
    chef.roles_path = "roles"
    chef.add_role("baseline")
    chef.add_role("web")
    chef.add_role("mongodb")
    chef.add_role("image_generation_server")
                
  end
end
