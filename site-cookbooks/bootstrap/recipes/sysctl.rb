#
# Cookbook Name:: bootstrap
# Recipe:: sysctl 
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Tweak some Linux sysctl values to improve networking
# performance etc.
directory "/etc/sysctl.d" do
  mode 0755
  owner "root"
  group "root"
  action :create
end

template "/etc/sysctl.d/70-gameimprovement-defaults.conf" do
  mode 0644
  owner "root"
  group "root"
  source "sysctl.conf.erb"
  cookbook "bootstrap"
end

node[:sysctl].each do |systcl, value|
  execute "Setting sysctl: #{systcl}" do
    command "sysctl -w #{systcl}=#{value}"
    action :run
  end
end
