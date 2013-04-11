template "/etc/monit/conf.d/nginx.conf" do
  mode "0644"
  source "nginx.conf"
end

template "/etc/monit/conf.d/delayed_job.conf" do
  mode "0644"
  source "delayed_job.conf"
end

template "/etc/monit/conf.d/resources.conf" do
  mode "0644"
  source "resources.conf"
end
