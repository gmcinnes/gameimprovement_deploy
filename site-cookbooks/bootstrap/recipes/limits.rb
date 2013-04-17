#
# Cookbook Name:: bootstrap
# Recipe:: limits 
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Increase system process limits, and open file limits for mongodb 
template "/etc/security/limits.conf" do
  cookbook "bootstrap"
  source "limits.conf.erb"
  group "root"
  owner "root"
  mode "0644"
end
