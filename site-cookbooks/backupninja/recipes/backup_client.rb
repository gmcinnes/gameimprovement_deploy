#
# Cookbook Name:: bootstrap
# Recipe:: backup_client 
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Backup this machine to an S3 bucket 

package "duplicity"
package "python-boto"
package "hwinfo"
package "debconf-utils"

aws_secrets = data_bag_item("secrets", "aws")
duplicity_secrets = data_bag_item("secrets", "duplicity")
%w{10.sys 90.dup}.each do |file|
  template "/etc/backup.d/#{file}" do
    action :create
    owner "root"
    group "root"
    variables :aws_access_key => aws_secrets['access_key'],
              :aws_secret_access_key => aws_secrets['secret_access_key'],
              :duplicity_password => duplicity_secrets['password']
  end
end

