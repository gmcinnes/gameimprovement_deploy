# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'berkshelf/vagrant'

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "apt"
    chef.add_recipe "unattended_upgrades"
    chef.add_recipe "gameimprovement_bootstrap"
    chef.add_recipe "gameimprovement_bootstrap::sysctl"
    chef.add_recipe "rbenv"
    chef.add_recipe "rbenv::ruby_build"
    chef.add_recipe "gameimprovement_bootstrap::install_ruby"
    chef.add_recipe "monit"
    chef.add_recipe "ntp"
    chef.add_recipe "vim"
    chef.add_recipe "ufw"
    chef.add_recipe "openssh"
    chef.add_recipe "sudo"
    chef.add_recipe "postfix"
    chef.add_recipe "nginx"
    chef.add_recipe "mongodb"
    chef.add_recipe "gameimprovement_bootstrap::limits"
    chef.add_recipe "gameimprovement_bootstrap::mongodb_ulimits"
    chef.add_recipe "nodejs"
    chef.add_recipe "npm"
    chef.add_recipe "gameimprovement_bootstrap::node_dependencies"
    chef.add_recipe "logrotate"
    chef.add_recipe "phantomjs"
    chef.add_recipe "fail2ban"
    chef.add_recipe "users"
    chef.json = {
      "limits" => {
        "mongodb" => {
          "nproc" => {
            "soft" => "32000",
            "hard" => "32001"
          },
          "nofile" => {
            "soft" => "64000",
            "hard" => "64001"
          }
        }
      },
      "unicorn" => {
        "worker_timeout" => "60",
        "preload_app"    => false,
        "before_fork"    => "sleep 1",
        "port"           => "8080",
        "options"        => { "tcp_nodelay" => true, "backlog" => 100 }
      },
      "sysctl" => { 
        # Sysctl Magic Shit (TM)
        
        # 256 KB default performs well experimentally, and is often recommended by ISVs.
        "net.core.rmem_default"      => "262144",
        "net.core.wmem_default"      => "262144",
      
        # Decrease the time default value for tcp_fin_timeout connection
        "net.ipv4.tcp_fin_timeout"    => "30",
       
        # Decrease the time default value for tcp_keepalive_time connection
        "net.ipv4.tcp_keepalive_time" => "1800",
       
        # support large window scaling RFC 1323
        "net.ipv4.tcp_window_scaling" => "1",
        
        # Filesystem I/O is usually much more efficient than swapping, so try to keep
        # swapping low.  It's usually safe to go even lower than this on systems with
        # server-grade storage.
        "vm.swappiness" => "0",
       
        # If a workload mostly uses anonymous memory and it hits this limit, the entire
        # working set is buffered for I/O, and any more write buffering would require
        # swapping, so it's time to throttle writes until I/O can catch up.  Workloads
        # that mostly use file mappings may be able to use even higher values.
        "vm.dirty_ratio" => "50",

        # Controls the System Request debugging functionality of the kernel
        "kernel.sysrq" => 1, 

        # reboot on panic
        "kernel.panic" => 30, 
        
        # Boost up the number of open files for mongodb
        "fs.file-max" => 102400

      },
      "authorization" => {
        "sudo" => {
          "groups" => ["admin", "wheel", "sysadmin"],
          "users"  => ["vagrant"],
          "passwordless" => "true"
        }
      },
      "firewall" => {
        "open ports for http" => {
          "port" => "8080"
        }
      }
    }
  end
end
