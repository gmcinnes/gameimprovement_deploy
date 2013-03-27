#Game Improvement Deploy Tools

This code provides three things:

* A Vagrantfile for spinning up a local VM for testing deployment
* A Berksfile for managing remote / community Chef cookbooks
* Site-cookbooks for doing jobs specific for Gameimprovement


## Install

### With Vagrant (local machine testing, or EC2)

* Install Vagrant http://www.vagrantup.com/
* Install Ruby Bundler http://gembundler.com/
* `bundle install --binstubs`
* `vagrant up`
* That's it.  You're done, motherfucker

### Not using Vagrant (remote production machine)

* Be root
* `curl -L https://www.opscode.com/chef/install.sh | sudo bash`
* `/opt/chef/embedded/bin/gem install berkshelf --no-ri --no-rdoc`
* `wget -O deploy.tar.gz https://api.github.com/repos/gmcinnes/gameimprovement_deploy/tarball`
* `tar -zxvf deploy.tar.gz`
* `cd gmcinnes-gameimprovement_deploy-82b9dba`
* `/opt/chef/embedded/bin/berks install --path vendor/cookbooks`
* Create data_bags/secrets/*.json files from data_bags/secrets/*.template files
* `/opt/chef/bin/chef-solo -c "$PWD"/solo.rb  -j "$PWD"/dna.json`

## Vagrantfile

The provided Vagrantfile is simplified from the default Vagrantfile. It only
contains options that are varied from the default.  For more details on the
possible options see http://docs.vagrantup.com/v2/vagrantfile/index.html

The only changes we make from the default Vagrantfile are:

* Use a 64 bit Ubuntu 12.04LTS vagrant box
* Forward port 8080 from the localhost to port 80 on the guest

## Berksfile

## Site cookbooks

