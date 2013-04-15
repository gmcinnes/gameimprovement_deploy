require 'berkshelf/vagrant'

Vagrant.configure("2") do |config|
  
  # This is an Ubuntu 12.04LTS 64-bit AMI provided by Amazon
  AWS_AMI =  'ami-3fec7956'
  
  # We store our credentials in a json file that we .gitignore so that
  # our Amazon credentials don't find themselves in indiscreet places
  AWS_CRED_FILENAME = File.dirname(__FILE__) + "/aws_credentials.json"
  if File.exist?(AWS_CRED_FILENAME)
    str = File.read(AWS_CRED_FILENAME)
    aws_creds = JSON.parse(str)
  end

  # Configure the aws provider with our chosen AMI and credentials.
  # There are other options that could go here.  See
  # https://github.com/mitchellh/vagrant-aws for details
  config.vm.provider :aws do |aws|
    aws.access_key_id = aws_creds['access_key_id']
    aws.secret_access_key = aws_creds['secret_access_key']
    aws.ami = AWS_AMI 
    aws.ssh_username = aws_creds['ssh_username'] 
    aws.keypair_name = aws_creds['keypair_name'] 
    aws.ssh_private_key_path = aws_creds['ssh_private_key_path'] 
  end
 
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
 
  # By default, Vagrant boxes, such as the one above, come with Chef
  # pre-installed.  That's very useful for testing.  But, because eventually
  # we're using Vagrant to deploy to a machine that will just be a bare Ubuntu
  # 12.04LTS instance, and won't have Chef pre-installed, we're going to rm -rf
  # the pre-installed Chef.  That keeps us consistant across the bare
  # production machine and any test VMs we spin up.  We do that with the 
  # shell provisioning below
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

  # Now *really* provision the machine with chef-solo
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
