#
# Cookbook Name:: bootstrap
# Recipe:: mongodb_backup 
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Add backupninja rules for backing up mongodb 
template "/etc/backup.d/31-db.mongodb" do
  action :create
  owner "root"
  group "root"
end

