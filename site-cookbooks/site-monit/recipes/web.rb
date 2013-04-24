#
# Cookbook Name:: site-monit 
# Recipe:: definitions 
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Add definitions for monit to monitor system wide resources,
# such as total CPU consumed, total MEM consumed, etc. 
template "/etc/monit/conf.d/nginx.conf" do
  mode "0644"
  source "nginx.conf"
end

template "/etc/monit/conf.d/delayed_job.conf" do
  mode "0644"
  source "delayed_job.conf"
end

