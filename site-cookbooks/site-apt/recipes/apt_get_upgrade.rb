#
# Cookbook Name:: site-apt 
# Recipe:: apt_get_upgrade
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Do a system wide apt-get upgrade
execute "apt-get upgrade" do
  command "apt-get upgrade -y --force-yes"
  ignore_failure true
end
