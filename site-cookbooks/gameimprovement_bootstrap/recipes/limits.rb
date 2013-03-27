template "/etc/security/limits.conf" do
  cookbook "gameimprovement_bootstrap"
  source "limits.conf.erb"
  group "root"
  owner "root"
  mode "0644"
end
