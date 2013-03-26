gameimprovement deploy
======================

#Game Improvement Deploy Tools

This code provides three things:

* A Vagrantfile for spinning up a local VM for testing deployment
* A Berksfile for managing remote / community Chef cookbooks
* Site-cookbooks for doing jobs specific for Gameimprovement


## Install

### Using Vagrant 


### Not using Vagrant

## Vagrantfile

The provided Vagrantfile is simplified from the default Vagrantfile. It only
contains options that are varied from the default.  For more details on the
possible options see http://docs.vagrantup.com/v2/vagrantfile/index.html

The only changes we make from the default Vagrantfile are:

* Use a 64 bit Ubuntu 12.04LTS vagrant box
* Forward port 8080 from the localhost to port 80 on the guest

## Berksfile

## Site cookbooks

