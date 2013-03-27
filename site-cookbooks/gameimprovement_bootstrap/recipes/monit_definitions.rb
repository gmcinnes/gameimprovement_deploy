template "/etc/monit/conf.d/unicorn.monitrc" do
  mode "0644"
  source "unicorn.monitrc"
end

template "/etc/monit/conf.d/nginx.monitrc" do
  mode "0644"
  source "nginx.monitrc"
end

