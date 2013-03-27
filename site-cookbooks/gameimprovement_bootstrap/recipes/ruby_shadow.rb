bash "install_ruby_shadow" do
  user "root"
  code <<-EOH
    /opt/vagrant_ruby/bin/gem install ruby-shadow
  EOH
end
