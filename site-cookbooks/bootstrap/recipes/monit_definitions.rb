template "/etc/monit/conf.d/unicorn.conf" do
  mode "0644"
  source "unicorn.conf"
end

template "/etc/monit/conf.d/nginx.conf" do
  mode "0644"
  source "nginx.conf"
end

(0..3).each do |n|
  template "/etc/monit/conf.d/unicorn_worker_#{n}.conf" do
    mode "0644"
    source "unicorn_worker_#{n}.conf"
  end

end

