template "/etc/monit/conf.d/unicorn.conf" do
  mode "0644"
  source "unicorn.conf"
end

template "/etc/monit/conf.d/nginx.conf" do
  mode "0644"
  source "nginx.conf"
end
