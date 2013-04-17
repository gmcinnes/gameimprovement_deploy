#
# Cookbook Name:: bootstrap
# Recipe:: monit_mongodb 
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Add monit definitions for mongodb. We do this in a different
# place from the monit_defintions recipe so that we can apply it in a
# different role
template "/etc/monit/conf.d/mongodb.conf" do
  mode "0644"
  source "mongodb.conf"
end

