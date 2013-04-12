package "backupninja"
package "hwinfo"
package "debconf-utils"
package "duplicity"
package "python-boto"

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
