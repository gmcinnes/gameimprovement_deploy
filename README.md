#Game Improvement Deploy Tools

This code provides three things:

* A Vagrantfile for spinning up a VM locally, or on AWS EC2, for testing deployment
* A Berksfile for managing remote / community Chef cookbooks
* Site-cookbooks for doing jobs specific for Gameimprovement


## Install

### Pre-requisites

* Install either [Virtualbox](https://www.virtualbox.org/wiki/Downloads) or
  [VMWare Fusion](https://my.vmware.com/web/vmware/evalcenter?p=vmware-fusion5)
* Clone this repo
* Install [Vagrant](http://www.vagrantup.com/)
* do: `vagrant plugin install vagrant-aws`
* Install [Ruby Bundler](http://gembundler.com/)
* Navigate to the top level of your clone and do: `bundle install --binstubs` 
* Create data\_bags/secrets/\*.json files from data\_bags/secrets/\*.json.template files

### Update local copy of vendor cookbooks

The deploy scripts need cookbooks developed by the Chef community in order to
run.  These cookbooks are managed by Berkshelf (see: http://berkshelf.com/).
In order to get the cookbooks you need locally:

* Navigate to the top level dir
* Do: `./bin/berks install --path=./vendor`

### Creating a local VM with Vagrant

* Just do `vagrant up` 
* You can use other vagrant commands (vagrant --help) to manage the machine

### Creating an EC2 host with Vagrant

* Just do `vagrant up --provider=aws`
* You can use other vagrant commands (vagrant --help) to manage the machine

### Not using Vagrant (remote production machine)

Make sure you are able to log into the remote host. 

On an Ubuntu 12.04LTS machine, the default remote user is usually **ubuntu**, 
plus whatever password you entered at setup time.

    cp nodes/localhost.json nodes/<my_server_ip>.json
    ./bin/knife solo prepare ubuntu@<my_server_ip>
    ./bin/knife solo cook ubuntu@<my_server_ip>


## Details

### Vagrantfile

The provided Vagrantfile is simplified from the default Vagrantfile. 

It only contains options that are varied from the default.  

For more details on the possible options see http://docs.vagrantup.com/v2/vagrantfile/index.html

The changes we make from the default Vagrantfile are:

* Use a 64 bit Ubuntu 12.04LTS vagrant box
* Forward port 8080 from the localhost to port 80 on the guest
* Add configuration for an AWS provider
* Change the default provisioning method to remove the Vagrant Box's 
  chef-client and install one from opscode.  (we do this so that the 
  chef-client used on vagrant VMs and bare, knife solo created machines
  are the same.  That way we don't encounter differences between production
  and development / staging environments)

### Berksfile

The provided Berksfile mostly contains cookbooks from the Opscode community
cookbook repository.

It contains the following deviations from that pattern:

* Add our local, gameimprovement specific cookbook, which is contained in this
  repository
* Use ufw firewall cookbook from github, because the community cookbook has
  issues with Chef 11
* Use chef-mongodb cookbook from github, because the official community
  cookbook has issues all over the place 

### Site cookbooks

Obviously, this stuff would all be uneccessary if there weren't any custom
requirements.  We layer custom setup for gameimprovment on top of the Opscode
community cookbooks by having site-cookbooks.  

Although we could split our customization up into multiple site-cookbooks, the
complexity is low enough at the moment that we only have one: **bootstrap**

* app\_bundle\_dependencies - Install XML libaries for Bundler to use when
  building Nokogiri 
* apt\_get\_upgrade - Do a system-wide apt-get upgrade
* backupninja - Install and configure Backupninja backup system
* install\_imagemagick - Install imagemagick library for graphics manipulation
* install\_postfix\_credentials - Install postfix credentials for upstream SMTP
  SASL connection
* install\_ruby - Install ruby 1.9.3-p392 via rbenv
* limits - Tweak system process number and file number limits for mongodb
* mongodb\_backup - Add backups for mongodb. We do this in a different place
  from the backupninja recipe so that we can apply it in a different role
  (see: Roles)
* monit\_definitions - Add definitions for monit to monitor system wide
  parameters
* monit\_init\_fix - Fix a bug in the monit init.d script (see:
  https://bugs.launchpad.net/ubuntu/+source/monit/+bug/993381)
* monit\_mongodb - Add monit definitions for mongodb. We do this in a different
  place from the monit\_defintions recipe so that we can apply it in a
  different role (see: Roles)
* node\_dependencies - Install dependencies for node.js
* sysctl - Change some Linux sysctl values to improve networking performance
  for a server, etc.
* tweak\_aliases\_for\_postfix - Add useful entries to /etc/aliases so that
  mail goes to the appropriate person

### Roles

The tasks in **bootstrap** are split into various roles, anticipating that our
current single server provisioning might split into multiple servers as load
grows.  Once that happens, we can assign a role to each particular server, or
group of servers.

##### Baseline 

The **Baseline** role is applied to every server. It contains configuration for
things like:

* apt (does an update, and turns on unattended security upgrades)
* ntp 
* postfix (installs upstream SMTP SASL configuration, adds the appropriate
  people to /etc/aliases and forwards root mail to them)
* ssh (prevents password login, prevents root login)
* vim
* sudo (adds appropriate people to passwordless sudo)
* monit (monitors general system resources and services like ssh and postfix)
* ufw (adds firewall, opens port 80 and 22)
* logrotate
* fail2ban (prevents multiple brute force attempts at ssh)
* ruby
* adds users
* basic backup

##### Web

The **Web** role is applied to _web servers_.   A server in this role runs both
a traditional Web server, Nginx, and one or more _application servers_,
Unicorn.  Obviously these roles could be split up  if neccessary.  This role
file:

* adds libraries neccessary for ruby Bundler (libxml, libslt etc)
* nginx (adds default configuration)
* monit configuration for monitoring nginx
* imagemagick

##### Mongodb

The **Mongodb** role provides a document oriented database service.  This is
just a simple mongodb instance.  This role file has configuration for;

* Installing and starting mongodb
* Configuring Ubuntu to increase open file and process limits to suit mongodb
* Adding a monit configuration to monitor mongodb
* Adding a backup configuration to backukp mongodb daily

##### Image Generation Server

The **Image Generation Server** role provides a facility for generating charts
via phantomjs.  It installs:

* nodejs
* npm
* node dependencies
* phantomjs itself
