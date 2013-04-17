#
# Cookbook Name:: bootstrap
# Recipe:: backupninja 
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Do a system wide apt-get upgrade
# Install and configure backupninja backup system
package "backupninja"

cookbook_file "/usr/share/backupninja/mongodb" do
  backup false
  action :create
  owner "root"
  group "root"
  source "mongodb"
  mode "0700"
end

cookbook_file "/usr/share/backupninja/mongodb.helper" do
  backup false
  action :create
  owner "root"
  group "root"
  source "mongodb.helper"
  mode "0700"
end

template "/etc/backupninja.conf" do
  action :create
  source "backupninja.conf.erb"
  mode "0700"
  owner "root"
  group "root"
end

