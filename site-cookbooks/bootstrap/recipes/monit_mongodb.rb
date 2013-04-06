template "/etc/monit/conf.d/mongodb.conf" do
  mode "0644"
  source "mongodb.conf"
end

