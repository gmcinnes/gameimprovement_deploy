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

  config.vm.provision :chef_solo do |chef|
    chef.data_bags_path = "data_bags"
    
    chef.roles_path = "roles"
    chef.add_role("baseline")
    chef.add_role("web")
    chef.add_role("mongodb")
    chef.add_role("image_generation_server")
                
    chef.json = {
      "openssh" => {
        "server" => {
          "subsystem" => "sftp internal-sftp",
          "password_authentication" => "no",
          "permit_root_login" => "no"
        }
      },
      "users" => ["deploy"],
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
          "users"  => ["vagrant", "deploy"],
          "passwordless" => "true"
        }
      },
      "firewall" => {
        "open ports for http" => {
          "port" => "80"
        }
      }
    }
  end
end
